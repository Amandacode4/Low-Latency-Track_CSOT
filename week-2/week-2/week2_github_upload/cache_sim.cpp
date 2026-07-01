#pragma GCC optimize("O3,unroll-loops,omit-frame-pointer,no-stack-protector,fast-math,strict-aliasing,inline-functions,tracer,peel-loops,prefetch-loop-arrays,split-loops,tree-vectorize")
#pragma GCC target("bmi2,sse4.1")

#include "cache_sim.hpp"
#include <cstdint>
#include <immintrin.h>

namespace {

struct alignas(64) Set {
    std::uint16_t tags[8];   // 16 bytes
    std::uint64_t lru;       // 8 bytes
    std::uint8_t  dirty;     // 1 byte
};

Set l1[64];
Set l2[512];

inline int find_way(const std::uint16_t* __restrict__ tags, std::uint16_t tag) {
    __m128i vtags = _mm_load_si128(reinterpret_cast<const __m128i*>(tags));
    __m128i vtag = _mm_set1_epi16(tag);
    __m128i cmp = _mm_cmpeq_epi16(vtags, vtag);
    int mask = _mm_movemask_epi8(cmp);
    // A 16-bit tag match will set TWO bytes to 0xFF, so we get two bits (e.g. 0x03)
    return mask;
}

inline void touch(std::uint64_t& state, int way) {
    if (__builtin_expect((state & 0xFF) == static_cast<std::uint64_t>(way), 1)) return;
    std::uint64_t way64 = 0x0101010101010101ULL * way;
    std::uint64_t cmp = state ^ way64;
    std::uint64_t hasZeroByte = (cmp - 0x0101010101010101ULL) & ~cmp & 0x8080808080808080ULL;
    int pos8 = __builtin_ctzll(hasZeroByte) - 7;
    // Perfect Math: _bzhi_u64 directly slices the lower bytes
    std::uint64_t state_shifted = _bzhi_u64(state, pos8) << 8;
    std::uint64_t state_kept = state & (0xFFFFFFFFFFFFFF00ULL << pos8);
    state = state_kept | state_shifted | way;
}

class OptCacheSim final : public csot::CacheSim {
public:
    void on_init() override {
        for (int s = 0; s < 64; ++s) {
            for (int w = 0; w < 8; ++w) l1[s].tags[w] = 0xFFFF;
            std::uint64_t init_lru = 0;
            for (std::uint64_t w = 0; w < 8; ++w) init_lru |= (w << (w * 8));
            l1[s].lru = init_lru;
            l1[s].dirty = 0;
        }
        for (int s = 0; s < 512; ++s) {
            for (int w = 0; w < 8; ++w) l2[s].tags[w] = 0xFFFF;
            std::uint64_t init_lru = 0;
            for (std::uint64_t w = 0; w < 8; ++w) init_lru |= (w << (w * 8));
            l2[s].lru = init_lru;
            l2[s].dirty = 0;
        }
    }

    [[gnu::hot, gnu::flatten]] csot::CacheStats run(const csot::MemAccess* acc, std::size_t n) override {
        std::size_t writes = 0;
        std::size_t l1_hits = 0;
        std::size_t l2_hits = 0;
        std::size_t dirty_writebacks = 0;

        std::uint64_t last_b = ~0ULL;
        int last_w = -1;

        // Force exactly 32-byte Micro-Op cache alignment for the unrolled loop
        __asm__ volatile(".p2align 5");
        #pragma GCC unroll 8
        for (std::size_t i = 0; i < n; ++i) {
            __builtin_prefetch(&acc[i + 8], 0, 0);

            const std::uint64_t b  = acc[i].address >> 6;
            const std::uint32_t wr = acc[i].is_write;
            writes += wr;

            if (__builtin_expect(b == last_b, 1)) {
                ++l1_hits;
                l1[b & 63].dirty |= (wr << last_w);
                continue;
            }

            const int s1 = b & 63;
            const std::uint16_t t1 = static_cast<std::uint16_t>(b >> 6);
            int mask1 = find_way(l1[s1].tags, t1);

            // Using epi8 means a match returns 0x03, 0x0C, etc. 
            // So __builtin_ctz returns 0, 2, 4... hence >> 1 gets the real way.
            if (__builtin_expect(mask1 != 0, 1)) {
                int w1 = __builtin_ctz(mask1) >> 1;
                ++l1_hits;
                touch(l1[s1].lru, w1);
                l1[s1].dirty |= (wr << w1);
                last_b = b;
                last_w = w1;
                continue;
            }

            const int v1 = l1[s1].lru >> 56;
            if ((l1[s1].dirty >> v1) & 1) {
                std::uint64_t dirty_block = (static_cast<std::uint64_t>(l1[s1].tags[v1]) << 6) | s1;
                int s2v = dirty_block & 511;
                std::uint16_t t2v = static_cast<std::uint16_t>(dirty_block >> 9);

                int mask2v = find_way(l2[s2v].tags, t2v);
                if (mask2v != 0) {
                    int w2v = __builtin_ctz(mask2v) >> 1;
                    l2[s2v].dirty |= (1 << w2v);
                } else {
                    int v2v = l2[s2v].lru >> 56;
                    dirty_writebacks += (l2[s2v].dirty >> v2v) & 1;
                    l2[s2v].dirty |= (1 << v2v);
                    l2[s2v].tags[v2v] = t2v;
                    touch(l2[s2v].lru, v2v);
                }
            }

            const int s2 = b & 511;
            const std::uint16_t t2 = static_cast<std::uint16_t>(b >> 9);
            int mask2 = find_way(l2[s2].tags, t2);

            if (__builtin_expect(mask2 != 0, 0)) {
                ++l2_hits;
                int w2 = __builtin_ctz(mask2) >> 1;
                touch(l2[s2].lru, w2);
            } else {
                int v2 = l2[s2].lru >> 56;
                dirty_writebacks += (l2[s2].dirty >> v2) & 1;
                l2[s2].dirty &= ~(1 << v2);
                l2[s2].tags[v2] = t2;
                touch(l2[s2].lru, v2);
            }

            l1[s1].dirty &= ~(1 << v1);
            l1[s1].dirty |= (wr << v1);
            l1[s1].tags[v1] = t1;
            l1[s1].lru = (l1[s1].lru << 8) | v1;
            
            last_b = b;
            last_w = v1;
        }

        csot::CacheStats st{};
        st.reads = n - writes;
        st.writes = writes;
        st.l1_hits = l1_hits;
        st.l1_misses = n - l1_hits;
        st.l2_hits = l2_hits;
        st.l2_misses = (n - l1_hits) - l2_hits;
        st.dirty_writebacks = dirty_writebacks;
        return st;
    }
};

} // namespace

extern "C" csot::CacheSim* create_cache_sim() {
    return new OptCacheSim();
}