#include "gateway.hpp"

#include <sys/socket.h>
#include <fcntl.h>

#include <cerrno>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <string>
#include <string_view>
#include <iostream>
#include <vector>

#ifdef __linux__
#include <sched.h>
#include <pthread.h>
#include <unistd.h>
// Needed for SO_BUSY_POLL if not defined
#ifndef SO_BUSY_POLL
#define SO_BUSY_POLL 46
#endif
#endif

namespace {

constexpr std::uint32_t WINDOW = 64;
constexpr double        ENTRY_Z = 2.0;
constexpr double        EXIT_Z = 0.5;
constexpr double        EPSILON_STDDEV = 1e-9;
constexpr double        INV_PRICE_SCALE = 1.0 / static_cast<double>(csot::PRICE_SCALE);
constexpr double        INV_WINDOW = 1.0 / static_cast<double>(WINDOW);

// ACK tuning
constexpr std::uint64_t ACK_BATCH = 32;

// ALIGN TO 64 BYTES TO ENABLE vmovapd AND PREVENT CACHE-LINE STRADDLING
struct alignas(64) SymbolState {
    double        mids[WINDOW] = {};
    std::uint32_t count = 0;
    std::uint32_t head = 0;
    std::int32_t  position = 0;
};

class FastGateway final : public csot::Gateway {
    char name_buf_[csot::NUM_SYMBOLS][8];
    std::string_view names_view_[csot::NUM_SYMBOLS];
    
    std::vector<SymbolState> state_;

    void pin_thread(int core_id) {
#ifdef __linux__
        cpu_set_t cpuset;
        CPU_ZERO(&cpuset);
        CPU_SET(core_id % sysconf(_SC_NPROCESSORS_ONLN), &cpuset);
        pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
#endif
    }

public:
    ~FastGateway() override = default;

    void on_init(std::uint32_t num_symbols) override {
        for (std::uint32_t k = 0; k < num_symbols; ++k) {
            std::string s = "SYM" + std::to_string(k);
            std::memcpy(name_buf_[k], s.c_str(), s.length() + 1);
            names_view_[k] = std::string_view(name_buf_[k], s.length());
        }
        state_.assign(num_symbols, SymbolState{});
    }

    std::size_t run(int fd, std::size_t n, csot::OrderRecord* out) override {
#ifdef __linux__
        pin_thread(0);
        // Enable kernel-level busy polling for ultra-low latency on the socket
        int busy_poll_us = 50;
        setsockopt(fd, SOL_SOCKET, SO_BUSY_POLL, &busy_poll_us, sizeof(busy_poll_us));
#endif

        std::size_t num_orders = 0;
        std::size_t processed = 0;
        std::uint64_t next_seq = 0;
        std::uint64_t unacked_count = 0;
            
#ifdef __linux__
        // Use recvmmsg to batch up to 32 datagrams in a SINGLE system call
        constexpr unsigned int VLEN = 32;
        struct mmsghdr msgs[VLEN];
        struct iovec iovecs[VLEN];
        alignas(64) unsigned char bufs[VLEN][csot::MAX_FEED_DATAGRAM_BYTES];
        
        for (unsigned int i = 0; i < VLEN; ++i) {
            iovecs[i].iov_base = bufs[i];
            iovecs[i].iov_len = csot::MAX_FEED_DATAGRAM_BYTES;
            msgs[i].msg_hdr.msg_name = nullptr;
            msgs[i].msg_hdr.msg_namelen = 0;
            msgs[i].msg_hdr.msg_iov = &iovecs[i];
            msgs[i].msg_hdr.msg_iovlen = 1;
            msgs[i].msg_hdr.msg_control = nullptr;
            msgs[i].msg_hdr.msg_controllen = 0;
        }
#else
        alignas(64) std::vector<unsigned char> dgram(csot::MAX_FEED_DATAGRAM_BYTES);
#endif
            
        while (processed < n) {
#ifdef __linux__
            int retval = recvmmsg(fd, msgs, VLEN, MSG_DONTWAIT, nullptr);
            if (retval < 0) {
                if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR) {
                    asm volatile("pause" ::: "memory");
                    continue;
                }
                break;
            }
            
            for (int i = 0; i < retval; ++i) {
                unsigned char* dgram_data = bufs[i];
#else
            const ssize_t k = ::recv(fd, dgram.data(), dgram.size(), MSG_DONTWAIT);
            if (k < 0) {
                if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR) {
#if defined(__x86_64__)
                    asm volatile("pause" ::: "memory");
#elif defined(__aarch64__)
                    asm volatile("yield" ::: "memory");
#endif
                    continue;
                }
                break;
            }
            unsigned char* dgram_data = dgram.data();
#endif
            
            csot::FeedDatagramHeader hdr;
            std::memcpy(&hdr, dgram_data, sizeof(hdr));
            
            const unsigned char* tick_bytes = dgram_data + sizeof(csot::FeedDatagramHeader);
            
            for (std::uint32_t j = 0; j < hdr.count && processed < n; ++j) {
                csot::WireTick w;
                std::memcpy(&w, tick_bytes + static_cast<std::size_t>(j) * sizeof(csot::WireTick), sizeof(csot::WireTick));
                
                const std::uint32_t sym = w.symbol_id;
                SymbolState& st = state_[sym];
                
                const double bid_px = static_cast<double>(w.bid_px_fp) * INV_PRICE_SCALE;
                const double ask_px = static_cast<double>(w.ask_px_fp) * INV_PRICE_SCALE;
                const double mid = (bid_px + ask_px) * 0.5;
                
                st.mids[st.head] = mid;
                st.head = (st.head + 1) & (WINDOW - 1);
                
                if (st.count < WINDOW) {
                    ++st.count;
                }

                if (st.count == WINDOW) {
                    double sum = 0.0;
                    const double* __restrict m = (const double*)__builtin_assume_aligned(st.mids, 64);
                    
                    #pragma GCC unroll 8
                    for (std::uint32_t idx = 0; idx < WINDOW; ++idx) sum += m[idx];
                    const double mean = sum * INV_WINDOW;

                    double sq = 0.0;
                    #pragma GCC unroll 8
                    for (std::uint32_t idx = 0; idx < WINDOW; ++idx) {
                        const double d = m[idx] - mean;
                        sq += d * d;
                    }
                    const double variance = sq * INV_WINDOW;
                    const double stddev = std::sqrt(variance);
                    
                    if (stddev >= EPSILON_STDDEV) {
                        const double z = (mid - mean) / stddev;
                        const double abs_z = std::fabs(z);
                        
                        if (st.position == 0) {
                            if (z >= ENTRY_Z) {
                                out[num_orders].tick_index = processed;
                                out[num_orders].order = {csot::Order::Side::SELL, names_view_[sym], bid_px, 1};
                                st.position = -1;
                                ++num_orders;
                            } else if (z <= -ENTRY_Z) {
                                out[num_orders].tick_index = processed;
                                out[num_orders].order = {csot::Order::Side::BUY, names_view_[sym], ask_px, 1};
                                st.position = 1;
                                ++num_orders;
                            }
                        } else if (st.position > 0 && abs_z <= EXIT_Z) {
                            out[num_orders].tick_index = processed;
                            out[num_orders].order = {csot::Order::Side::SELL, names_view_[sym], bid_px, static_cast<std::uint32_t>(st.position)};
                            st.position = 0;
                            ++num_orders;
                        } else if (st.position < 0 && abs_z <= EXIT_Z) {
                            out[num_orders].tick_index = processed;
                            out[num_orders].order = {csot::Order::Side::BUY, names_view_[sym], ask_px, static_cast<std::uint32_t>(-st.position)};
                            st.position = 0;
                            ++num_orders;
                        }
                    }
                }
                
                ++processed;
            }
            
            next_seq = hdr.seq + 1;
            unacked_count++;
            
            if (unacked_count >= ACK_BATCH || processed == n) {
                (void)::send(fd, &next_seq, sizeof(next_seq), 0);
                unacked_count = 0;
            }
#ifdef __linux__
            } // end for loop over batched messages
#endif
        }
        
        return num_orders;
    }
};

}  // namespace

extern "C" csot::Gateway* create_gateway() {
    return new FastGateway();
}
