#include <cstdint>
#include <cstddef>
constexpr std::int64_t INF_MAX = 9223372036854775807LL;
constexpr std::int64_t INF_MIN = -9223372036854775807LL - 1;

struct AggTick {
    std::uint64_t timestamp_ns;
    std::int64_t  price;
    std::uint32_t symbol_id;
    std::uint32_t qty;
    std::uint64_t _reserved;
};

struct alignas(32) AlignedSymbolAgg {
    std::uint32_t count;
    std::uint32_t padding;
    std::int64_t  sum_price;
    std::int64_t  min_price;
    std::int64_t  max_price;
};

void process_manual(const AggTick* p, const AggTick* p_end, AlignedSymbolAgg* local_out, std::uint64_t* local_qtys) {
    #pragma GCC unroll 8
    while (p + 2 <= p_end) {
        std::uint32_t s0 = p[0].symbol_id;
        std::uint32_t s1 = p[1].symbol_id;
        AlignedSymbolAgg& r0 = local_out[s0];
        AlignedSymbolAgg& r1 = local_out[s1];
        const std::int64_t pr0 = p[0].price;
        const std::int64_t pr1 = p[1].price;
        if (__builtin_expect(pr0 < r0.min_price, 0)) r0.min_price = pr0;
        if (__builtin_expect(pr1 < r1.min_price, 0)) r1.min_price = pr1;
        if (__builtin_expect(pr0 > r0.max_price, 0)) r0.max_price = pr0;
        if (__builtin_expect(pr1 > r1.max_price, 0)) r1.max_price = pr1;
        r0.count++;
        r1.count++;
        r0.sum_price += pr0;
        r1.sum_price += pr1;
        local_qtys[s0] += p[0].qty;
        local_qtys[s1] += p[1].qty;
        p += 2;
    }
}

void process_auto(const AggTick* p, const AggTick* p_end, AlignedSymbolAgg* local_out, std::uint64_t* local_qtys) {
    #pragma GCC unroll 8
    while (p < p_end) {
        std::uint32_t s = p->symbol_id;
        AlignedSymbolAgg& r = local_out[s];
        const std::int64_t pr = p->price;
        if (__builtin_expect(pr < r.min_price, 0)) r.min_price = pr;
        if (__builtin_expect(pr > r.max_price, 0)) r.max_price = pr;
        r.count++;
        r.sum_price += pr;
        local_qtys[s] += p->qty;
        ++p;
    }
}
