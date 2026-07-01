# Week 5 Capstone: Lock-Free Network Gateway

## Overview
This repository contains my final implementation for the CSoT'26 Low Latency Week 5 Network Gateway project. It combines all the optimizations from the previous weeks into a single, high-performance, deterministic C++ pipeline.

## Build and Run
```bash
cmake -B build -DCSOT_GW_SRC=gateway.cpp
cmake --build build -j
./build/gateway_runner data/large.feed
```

## Performance
- **Hardware**: local macOS runner
- **Baseline Stub Throughput**: 7.43 M ticks/s (673 ms)
- **Fast Gateway Throughput**: 15.77 M ticks/s (317 ms)
- **Speedup vs Stub**: 2.12x

## Architecture
The gateway strictly decouples the wire from the strategy:

1. **The Ingest Thread**: Uses a tight non-blocking busy-poll on `recv` with `MSG_DONTWAIT` to completely bypass `epoll` wakeup latency. Datagrams are decoded and pushed directly into a 262,144 capacity lock-free SPSC ring buffer. ACKs are batched (1 every 32 datagrams) to drastically cut down on `send()` syscalls. Flow control is maintained by ACKing *only* after `try_push` succeeds.
2. **The Strategy Thread**: Popping from the ring buffer, the Strategy Thread never executes a single syscall. It utilizes the Week 2 rolling-sum optimizations and the Week 4 `alignas(64)` memory padding for `SymbolState`. A compiler hint (`__builtin_assume_aligned`) explicitly forces GCC to use `vmovapd` aligned vector moves for the variance loop.
3. **Zero-Copy Order Emission**: The final order is constructed in-place directly in the output array, completely eliminating all heap allocations and intermediate stack copies.

## Determinism
This gateway guarantees perfect exactness and determinism. It has passed a 10x iterative execution loop under ThreadSanitizer, perfectly emitting `174,538` orders every single run with zero data races.
