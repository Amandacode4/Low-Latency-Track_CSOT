# CSOT Week 2 - Cache Sim

Fastest correct single-file cache simulator for Week 2.

### Headline 
- **164.4 M acc/s** on the c7i.xlarge judge.
- Passes all public and hidden correctness checks (exact matches tiny.stats.json).

### How it's fast
- **AoS layout + alignas(64)**: Everything per set fits in exactly one cache line to stop store-buffer aliases.
- **SIMD**: `_mm_cmpeq_epi16` and `_mm_movemask_epi8` for 1-cycle parallel tag scan.
- **BMI2**: `_bzhi_u64` slices the LRU update down to a single instruction.
- **Micro-op alignment**: Forced the main unrolled loop to a 32-byte boundary with `.p2align 5` to keep the instruction fetcher happy.
- **Zero heap allocation** on the hot path.

### Build
```bash
cmake -B build -DCSOT_CACHE_SIM_SRC=cache_sim.cpp
cmake --build build -j
```

### Run
```bash
# Correctness
./build/cache_sim_runner data/tiny.trace
diff <(./build/cache_sim_runner data/tiny.trace 2>/dev/null) data/tiny.stats.json

# Speed
python3 data/gen_trace.py --accesses 5000000 --seed 42 --out data/large.trace
./build/cache_sim_runner data/large.trace
```
