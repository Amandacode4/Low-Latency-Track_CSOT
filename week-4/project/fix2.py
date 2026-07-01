import re
with open('pipeline.cpp', 'r') as f:
    code = f.read()

new_logic = """                    if (st.position == 0) {
                        if (z >= ENTRY_Z) {
                            order = {csot::Order::Side::SELL, names_[sym], item.bid_px, 1};
                            st.position -= 1;
                            emit = true;
                        } else if (z <= -ENTRY_Z) {
                            order = {csot::Order::Side::BUY, names_[sym], item.ask_px, 1};
                            st.position += 1;
                            emit = true;
                        }
                    } else if (st.position > 0 && abs_z <= EXIT_Z) {
                        order = {csot::Order::Side::SELL, names_[sym], item.bid_px, static_cast<std::uint32_t>(st.position)};
                        st.position = 0;
                        emit = true;
                    } else if (st.position < 0 && abs_z <= EXIT_Z) {
                        order = {csot::Order::Side::BUY, names_[sym], item.ask_px, static_cast<std::uint32_t>(-st.position)};
                        st.position = 0;
                        emit = true;
                    }"""

old_logic = """                    if (st.position == 0) {
                        if (z >= ENTRY_Z) {
                            order = {csot::Order::Side::SELL, names_[sym], item.bid_px, 1};
                            st.position -= 1;
                            emit = true;
                        } else if (z <= -ENTRY_Z) {
                            order = {csot::Order::Side::BUY, names_[sym], item.ask_px, 1};
                            st.position += 1;
                            emit = true;
                        }
                    } else if (st.position > 0) {
                        if (z >= EXIT_Z) {
                            order = {csot::Order::Side::SELL, names_[sym], item.bid_px, 1};
                            st.position -= 1;
                            emit = true;
                        }
                    } else {
                        if (z <= -EXIT_Z) {
                            order = {csot::Order::Side::BUY, names_[sym], item.ask_px, 1};
                            st.position += 1;
                            emit = true;
                        }
                    }"""

code = code.replace(old_logic, new_logic)

with open('pipeline.cpp', 'w') as f:
    f.write(code)
