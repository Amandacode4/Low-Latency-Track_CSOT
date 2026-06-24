# Week 3 Fast Parallel Tick Aggregator

This project implements a highly optimized, lock-free MapReduce engine to process a binary tick stream across multiple CPU cores without data races or false sharing.

## Build Instructions
```bash
cmake -B build -DCSOT_AGG_SRC=aggregator.cpp
cmake --build build -j
./build/agg_runner data/large.ticks
```

## Hardware
- **OS**: macOS
- **CPU**: Apple M4 (10 cores)

## Headline Numbers
- **Throughput**: 1678.91 M ticks/s (local test)
- **Score achieved on Judge**: 159.1
- **Speedup vs 1 Thread**: ~5.5x

## Core Optimizations
1. **Unbalanced Chunks & Pipelined Merging**: Instead of having the main thread wait for all workers to finish, we give the workers 26% of the work and the main thread 22%. The main thread finishes early, instantly folds its own data, and pipelines the sequential merge while the trailing workers finish. This perfectly hides the merge latency.
2. **64-bit ID/QTY Packed Loads**: Using the layout of the `AggTick` struct, we load `symbol_id` and `qty` simultaneously using a single `memcpy` of 8 bytes. This halves the memory loads and arithmetic operations in the absolute hottest part of our loop.
3. **`alignas(64)` Perfect L1 Packing**: By aligning the per-thread tables to 64 bytes, we guarantee each symbol is perfectly aligned to its own cache line, completely eliminating false sharing.
4. **`__builtin_expect` (Branch Prediction)**: We use branch prediction for `min`/`max` comparisons instead of branchless `CMOV`. Conditional moves cause a massive data dependency bottleneck, whereas branches allow the CPU to completely bypass the memory write 99% of the time.

## What Surprised Me
I was incredibly surprised that removing branches (branchless programming) actually *slowed down* the code on modern cloud instances. I learned that for variables that rarely change (like all-time minimum and maximum prices), the CPU's branch predictor gets it right almost every time, breaking the data dependency chain. Forcing the CPU to do the read-compare-write cycle via `std::min` (which compiles to `CMOV`) destroyed the Instruction Level Parallelism (ILP).
