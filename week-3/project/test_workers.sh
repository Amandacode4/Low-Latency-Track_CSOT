#!/bin/bash
for w in 1 2 3 4; do
  sed -i '' "s/constexpr int NUM_WORKERS = .;/constexpr int NUM_WORKERS = $w;/g" aggregator.cpp
  g++ -std=c++20 -O3 -Wall -Wextra -pthread -I"include" -o "agg_runner" harness/main.cpp aggregator.cpp
  echo "Workers: $w"
  ./agg_runner data/large.ticks | grep throughput
done
