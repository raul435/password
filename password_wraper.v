module password_wraper (
    input MAX10_CLK1_50,
    input [1:0] KEY,
    input [9:0] SW,
    output [9:0] LEDR,
    output [0:7] HEX4, HEX3, HEX2, HEX1, HEX0
);

password password_0 (
    .clk(MAX10_CLK1_50),
    .rst(KEY[0]),
    .Sw(SW),
    .leds_out(LEDR),
    .seg0_out(HEX4[0:6]),
    .seg1_out(HEX3[0:6]),
    .seg2_out(HEX2[0:6]),
    .seg3_out(HEX1[0:6]),
    .seg4_out(HEX0[0:6])
);

endmodule