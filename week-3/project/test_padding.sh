#!/bin/bash
# Test 40 byte
sed -i '' 's/constexpr int NUM_WORKERS = 2;/constexpr int NUM_WORKERS = 4;/g' aggregator.cpp
g++ -std=c++20 -O3 -Wall -Wextra -pthread -I"include" -o "agg_runner" harness/main.cpp aggregator.cpp
echo "40-byte:"
./agg_runner data/large.ticks | grep throughput

# Modify to PaddedSymbol
sed -i '' 's/csot::SymbolAgg partials\[NUM_WORKERS\]\[1024\];/struct alignas(64) PaddedSymbol { std::uint64_t count; std::int64_t sum_price; std::int64_t min_price; std::int64_t max_price; std::uint64_t sum_qty; };\n\nalignas(64) PaddedSymbol partials[NUM_WORKERS][1024];/g' aggregator.cpp
sed -i '' 's/csot::SymbolAgg\* local_out = partials/PaddedSymbol\* local_out = partials/g' aggregator.cpp
sed -i '' 's/local_out\[s\] = csot::SymbolAgg{0, 0, 0, 0, 0};/local_out[s] = PaddedSymbol{0, 0, 0, 0, 0};/g' aggregator.cpp
sed -i '' 's/csot::SymbolAgg\&     r = local_out\[t.symbol_id\];/PaddedSymbol\& r = local_out[t.symbol_id];/g' aggregator.cpp
sed -i '' 's/const csot::SymbolAgg\* local_out = partials\[i\];/const PaddedSymbol\* local_out = partials[i];/g' aggregator.cpp
sed -i '' 's/const csot::SymbolAgg\& p = local_out\[s\];/const PaddedSymbol\& p = local_out[s];/g' aggregator.cpp

g++ -std=c++20 -O3 -Wall -Wextra -pthread -I"include" -o "agg_runner" harness/main.cpp aggregator.cpp
echo "64-byte padded:"
./agg_runner data/large.ticks | grep throughput
