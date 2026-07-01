#include <cstdint>
#include <iostream>

int main() {
    std::uint64_t count_and_qty = 0;
    
    // Add 1 to count, and 150 to qty
    count_and_qty += (1ULL << 32) | 150;
    
    // Add 1 to count, and 200 to qty
    count_and_qty += (1ULL << 32) | 200;
    
    std::uint32_t count = count_and_qty >> 32;
    std::uint32_t qty = count_and_qty & 0xFFFFFFFF;
    
    std::cout << "Count: " << count << " Qty: " << qty << std::endl;
    return 0;
}
