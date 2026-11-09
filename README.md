# Nanosecond Trading Systems in C++20

**Aman Dangar · IIT Delhi · CSoT'26 Low Latency track (DevClub IIT Delhi)**

Five weeks of building the pieces of a trading platform where the score is latency: a strategy that
reacts in nanoseconds, a multithreaded aggregator, a lock-free pipeline between threads, and a UDP
market-data gateway. Every week was judged on a live leaderboard.

## Results

| Week | What I built | Result | Code |
|---|---|---|---|
| 1 | Moving-average strategy as a shared library | **Rank #1** on the live leaderboard · score 177.3 · **18 ns p50 / 38 ns p99** · 20.06 M ticks/s | [`week-1/project/the_submission_week_1`](week-1/project/the_submission_week_1) |
| 3 | Parallel tick aggregator (`std::thread`) | Judge score 159.1 · ~1,678 M ticks/s on an Apple M4 · **~5.5× over single-threaded** | [`week-3/week_3_submission`](week-3/week_3_submission) |
| 4 | Two-thread streaming pipeline with a lock-free ring buffer | z-score mean-reversion signal per symbol (64-tick window) | [`week-4/project/pipeline.cpp`](week-4/project/pipeline.cpp) |
| 5 | UDP market-data gateway | Batched receive with `recvmmsg`, busy polling, pinned core | [`week-5/project/gateway.cpp`](week-5/project/gateway.cpp) |

## How the fast paths work

**Week 1, the strategy (18 ns median).** Nothing on the hot path allocates: per-symbol state lives in
preallocated fixed-size arrays, anything else comes from a bump allocator over one preallocated region,
and data that is read together is stored together. Built with `-O3 -march=x86-64-v3 -flto`.

**Week 3, the aggregator (5.5× speed-up).**
- *Cache-line padding.* Each thread's partial results are `alignas(64)`, so cores stop invalidating each
  other's cache lines (false sharing).
- *Unbalanced chunks.* Workers get 26% of the data each and the main thread 22%, so the main thread
  finishes first and starts merging while the others finish.
- *One load instead of two.* `symbol_id` and `qty` sit next to each other, so one 64-bit load fetches both.
- *Branches beat branchless.* My branchless `min`/`max` was **slower**: it created a dependency chain on
  every tick. With `__builtin_expect`, the predictor guesses correctly almost every time that the extreme
  doesn't change, and the store is skipped. Measuring this changed how I think about "obvious" optimisations.

**Week 4, the pipeline.** A single-producer single-consumer ring buffer (2¹⁸ slots, power-of-two masking)
connects a parser thread and a strategy thread. Head and tail are `std::atomic` on separate cache lines with
acquire/release ordering, and each side caches the other's index to avoid touching the shared line on every
item. Per-symbol state is `alignas(64)` so one vector load never straddles two lines. Threads are pinned to cores.

**Week 5, the gateway.** Non-blocking UDP socket with `SO_BUSY_POLL`; `recvmmsg` pulls up to 32 datagrams
per system call instead of one, cutting kernel crossings; the receive loop runs on a pinned core.

## What this taught me that carries over to ML

The same questions decide whether a model runs fast: where the data lives in memory, what each core is
waiting on, and whether a measured profile agrees with the intuition. I'm interested in applying this to
efficient inference and ML systems.

The original course material is kept in [`COURSE.md`](COURSE.md) and the `week-*/` lesson notes.

---
*Contact: amandangar102@gmail.com · [LinkedIn](https://www.linkedin.com/in/amandangar/)*
