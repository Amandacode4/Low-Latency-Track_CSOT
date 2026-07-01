#include <iostream>
#include <cstdint>
struct AggTick {
    std::int64_t price;
    std::uint32_t symbol_id;
    std::uint32_t qty;
    std::uint64_t timestamp;
    std::uint64_t _padding;
};
int main() {
    AggTick tick = { 1000, 42, 500, 0, 0 };
    std::uint64_t sq = *(const std::uint64_t*)((const char*)&tick + 8);
    std::uint32_t s = (std::uint32_t)sq;
    std::uint32_t q = sq >> 32;
    std::cout << "s: " << s << " q: " << q << std::endl;
    return 0;
}
