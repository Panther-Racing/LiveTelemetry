set clock_constraint { \
    name clk \
    module decode_can_message \
    port ap_clk \
    period 10 \
    uncertainty 0.5 \
}

set all_path {}

set false_path {}

