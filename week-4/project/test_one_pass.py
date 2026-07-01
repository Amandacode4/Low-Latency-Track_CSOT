import re
with open('pipeline.cpp', 'r') as f:
    code = f.read()

old_loop = """                    double sum = 0.0;
                    #pragma GCC unroll 8
                    for (std::uint32_t i = 0; i < WINDOW; ++i) sum += st.mids[i];
                    const double mean = sum / static_cast<double>(WINDOW);

                    double sq = 0.0;
                    #pragma GCC unroll 8
                    for (std::uint32_t i = 0; i < WINDOW; ++i) {
                        const double d = st.mids[i] - mean;
                        sq += d * d;
                    }
                    const double variance = sq / static_cast<double>(WINDOW);"""

new_loop = """                    double sum = 0.0;
                    double sum_sq = 0.0;
                    #pragma GCC unroll 8
                    for (std::uint32_t i = 0; i < WINDOW; ++i) {
                        const double m = st.mids[i];
                        sum += m;
                        sum_sq += m * m;
                    }
                    const double mean = sum / static_cast<double>(WINDOW);
                    const double variance = std::max(0.0, (sum_sq / static_cast<double>(WINDOW)) - (mean * mean));"""

code = code.replace(old_loop, new_loop)

with open('pipeline_one_pass.cpp', 'w') as f:
    f.write(code)
