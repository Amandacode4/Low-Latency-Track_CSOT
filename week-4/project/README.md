# Week 4 Lock-Free Pipeline

This project implements a Lock-Free Single-Producer Single-Consumer pipeline to decode a `WireTick` feed and execute a Z-Score mean-reversion strategy across two distinct CPU cores.

## Build Steps
```bash
cmake -B build -DCSOT_PIPE_SRC=pipeline.cpp
cmake --build build -j
./build/pipeline_runner data/large.feed
```

## Hardware
- OS: macOS
- CPU: Apple M4
- Cores: 10

## Headline Numbers
- **Baseline (Single-Threaded Stub)**: 28.66 M ticks/s
- **Lock-Free SPSC Pipeline**: 121.94 M ticks/s
- **Speedup vs Serial**: 4.25x

## Performance Details
The incredible 4.25x speedup is achieved by combining multithreading with an algorithmic optimization:
1. **Lock-Free SPSC Ring Buffer**: Eliminates the overhead of mutexes and completely hides the fixed-point to double decoding latency by placing it on the Producer thread.
2. **False-Sharing Prevention**: The `head` and `tail` atomic counters are separated using `alignas(64)`, preventing cache-line ping-ponging between the two cores.
3. **Pipelined Batching**: The consumer batches `tail` updates (publishing its progress every 64 ticks), which reduces memory barrier traffic.
4. **Algorithmic Z-Score**: The consumer calculates the Z-Score using a Rolling Sum / Sum of Squares $O(1)$ algorithm instead of the naive $O(W)$ loop.

## What Surprised Me
I was surprised that batching the atomic updates for the `tail` cursor yielded such a measurable difference in throughput. Even when memory is correctly ordered and cache lines don't false-share, the raw cost of pushing an atomic store through the coherency protocol back to the producer thread can bottleneck the system. Batching it drastically reduced coherency traffic.
