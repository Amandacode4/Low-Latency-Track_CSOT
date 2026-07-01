#include <cstdint>

struct Tick {
    uint64_t timestamp;
    const char* symbol;
    double bid_px;
    double ask_px;
    uint32_t bid_qty;
    uint32_t ask_qty;
};

double get_price(const Tick& t, bool is_sell) {
    return is_sell ? t.bid_px : t.ask_px;
}
