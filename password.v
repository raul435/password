module password (
    input clk, rst,
    input [9:0] Sw,
    output [9:0] leds_out,
    output [7:0] seg0_out, seg1_out, seg2_out, seg3_out, seg4_out
);

parameter IDLE = 0;
parameter digit_2 = 1;
parameter digit_3 = 2;
parameter digit_4 = 3;
parameter done = 4;
parameter error = 5;

reg [3:0] state;

// clkdiv a 1KHz
wire clk_1KHz;
clkdiv #(50000) clk_div_1KHz (
    .clk(clk),
    .rst(rst),
    .clk_div(clk_1KHz)
);

//one_shot
wire [9:0] senal_one_shot;
one_shot one_shot_0 (clk_1KHz, Sw[0], senal_one_shot[0]);
one_shot one_shot_1 (clk_1KHz, Sw[1], senal_one_shot[1]);
one_shot one_shot_2 (clk_1KHz, Sw[2], senal_one_shot[2]);
one_shot one_shot_3 (clk_1KHz, Sw[3], senal_one_shot[3]);
one_shot one_shot_4 (clk_1KHz, Sw[4], senal_one_shot[4]);
one_shot one_shot_5 (clk_1KHz, Sw[5], senal_one_shot[5]);
one_shot one_shot_6 (clk_1KHz, Sw[6], senal_one_shot[6]);
one_shot one_shot_7 (clk_1KHz, Sw[7], senal_one_shot[7]);
one_shot one_shot_8 (clk_1KHz, Sw[8], senal_one_shot[8]);
one_shot one_shot_9 (clk_1KHz, Sw[9], senal_one_shot[9]);

//verificador
wire [3:0] status_out;
verificador verificador_0 (rst, clk_1KHz, senal_one_shot, status_out);

//imprime
imprime imprime_0 (clk_1KHz, rst, status_out, leds_out, seg0_out, seg1_out, seg2_out, seg3_out, seg4_out);

endmodule
