#include "pipeline.hpp"
#include <cmath>
#include <atomic>
#include <thread>
#include <vector>
#include <string>
#include <iostream>

#ifdef __linux__
#include <sched.h>
#include <pthread.h>
#include <unistd.h>
#endif

namespace {

constexpr std::uint32_t WINDOW = 64;
constexpr std::size_t   RING_CAPACITY = 262144;
constexpr std::size_t   RING_MASK = RING_CAPACITY - 1;
constexpr double        ENTRY_Z = 2.0;
constexpr double        EXIT_Z = 0.5;
constexpr double        EPSILON_STDDEV = 1e-9;

struct SymbolState {
    double        mids[WINDOW] = {};
    std::uint32_t count = 0;
    std::uint32_t head = 0;
    std::int32_t  position = 0;
};

// Exactly 32 bytes for perfect cache alignment
struct RingItem {
    std::uint64_t tick_index;
    double bid_px;
    double ask_px;
    std::uint32_t symbol_id;
};

class FastPipeline : public csot::Pipeline {
    std::vector<std::string> names_;
    std::vector<SymbolState> state_;
    std::uint32_t num_symbols_ = 0;

    RingItem* ring_ = nullptr;
    alignas(64) std::atomic<std::uint64_t> head_{0};
    alignas(64) std::atomic<std::uint64_t> tail_{0};

    void pin_thread(int core_id) {
#ifdef __linux__
        cpu_set_t cpuset;
        CPU_ZERO(&cpuset);
        CPU_SET(core_id % sysconf(_SC_NPROCESSORS_ONLN), &cpuset);
        pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
#endif
    }

public:
    ~FastPipeline() override {
        delete[] ring_;
    }

    void on_init(std::uint32_t num_symbols) override {
        num_symbols_ = num_symbols;
        names_.resize(num_symbols);
        for (std::uint32_t k = 0; k < num_symbols; ++k) {
            names_[k] = "SYM" + std::to_string(k);
        }
        state_.assign(num_symbols, SymbolState{});
        ring_ = new RingItem[RING_CAPACITY];
    }

    std::size_t run(const csot::WireTick* in, std::size_t n, csot::OrderRecord* out) override {
        if (n == 0) return 0;
        
        head_.store(0, std::memory_order_relaxed);
        tail_.store(0, std::memory_order_relaxed);

        std::size_t num_orders = 0;

        auto producer = [&]() {
            pin_thread(0);
            std::uint64_t h = 0;
            std::uint64_t cached_tail_ = 0;
            
            for (std::size_t i = 0; i < n; ++i) {
                const csot::WireTick& w = in[i];
                
                // Spin until space is available
                while (h - cached_tail_ >= RING_CAPACITY) {
                    cached_tail_ = tail_.load(std::memory_order_acquire);
#if defined(__x86_64__)
                    asm volatile("pause" ::: "memory");
#elif defined(__aarch64__)
                    asm volatile("yield" ::: "memory");
#endif
                }
                
                RingItem& item = ring_[h & RING_MASK];
                item.tick_index = i;
                item.bid_px = static_cast<double>(w.bid_px_fp) / static_cast<double>(csot::PRICE_SCALE);
                item.ask_px = static_cast<double>(w.ask_px_fp) / static_cast<double>(csot::PRICE_SCALE);
                item.symbol_id = w.symbol_id;
                
                h++;
                // Batch head updates to prevent consumer cache bouncing
                if ((h & 255) == 0) {
                    head_.store(h, std::memory_order_release);
                }
            }
            // Final flush
            head_.store(h, std::memory_order_release);
        };

        std::thread prod_thread(producer);

        auto consumer = [&]() {
            pin_thread(1);
            std::uint64_t t = 0;
            std::uint64_t cached_head_ = 0;
            
            while (t < n) {
                while (cached_head_ <= t) {
                    cached_head_ = head_.load(std::memory_order_acquire);
#if defined(__x86_64__)
                    asm volatile("pause" ::: "memory");
#elif defined(__aarch64__)
                    asm volatile("yield" ::: "memory");
#endif
                }
                
                const RingItem& item = ring_[t & RING_MASK];
                const std::uint32_t sym = item.symbol_id;
                SymbolState& st = state_[sym];
                const double mid = (item.bid_px + item.ask_px) * 0.5;
                
                st.mids[st.head] = mid;
                st.head = (st.head + 1) & (WINDOW - 1);
                
                if (st.count < WINDOW) {
                    ++st.count;
                }

                if (st.count == WINDOW) {
                    double sum = 0.0;
                    double sum_sq = 0.0;
                    #pragma GCC unroll 8
                    for (std::uint32_t i = 0; i < WINDOW; ++i) {
                        const double m = st.mids[i];
                        sum += m;
                        sum_sq += m * m;
                    }
                    const double mean = sum / static_cast<double>(WINDOW);
                    const double variance = std::max(0.0, (sum_sq / static_cast<double>(WINDOW)) - (mean * mean));
                    const double stddev = std::sqrt(variance);
                    
                    if (stddev >= EPSILON_STDDEV) {
                        const double z = (mid - mean) / stddev;
                        const double abs_z = std::fabs(z);
                        
                        csot::Order order;
                        bool emit = false;

                        if (st.position == 0) {
                            if (z >= ENTRY_Z) {
                                order = {csot::Order::Side::SELL, names_[sym], item.bid_px, 1};
                                st.position -= 1;
                                emit = true;
                            } else if (z <= -ENTRY_Z) {
                                order = {csot::Order::Side::BUY, names_[sym], item.ask_px, 1};
                                st.position += 1;
                                emit = true;
                            }
                        } else if (st.position > 0 && abs_z <= EXIT_Z) {
                            order = {csot::Order::Side::SELL, names_[sym], item.bid_px, static_cast<std::uint32_t>(st.position)};
                            st.position = 0;
                            emit = true;
                        } else if (st.position < 0 && abs_z <= EXIT_Z) {
                            order = {csot::Order::Side::BUY, names_[sym], item.ask_px, static_cast<std::uint32_t>(-st.position)};
                            st.position = 0;
                            emit = true;
                        }

                        if (emit) {
                            out[num_orders].tick_index = item.tick_index;
                            out[num_orders].order = order;
                            ++num_orders;
                        }
                    }
                }
                
                t++;
                // Batch tail updates to completely eliminate cache coherency storms on the Producer's spin-lock
                if ((t & 2047) == 0) {
                    tail_.store(t, std::memory_order_release);
                }
            }
            // Final flush
            tail_.store(t, std::memory_order_release);
        };

        consumer();
        prod_thread.join();
        
        return num_orders;
    }
};

}  // namespace

extern "C" csot::Pipeline* create_pipeline() {
    return new FastPipeline();
}
