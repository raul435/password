module imprime (
    input clk, rst, 
    input [3:0] state,
    output reg [9:0] leds_out,
    output reg [0:6] seg0_out, seg1_out, seg2_out, seg3_out, seg4_out
);

parameter IDLE = 0;
parameter digit_2 = 1;
parameter digit_3 = 2;
parameter digit_4 = 3;
parameter done = 4;
parameter error = 5;

always @(state)
begin
    if (!rst) begin
        leds_out  <= 10'b1000000000;
        seg0_out  <= 7'b0000000;
        seg1_out  <= 7'b0000000;
        seg2_out  <= 7'b0000000;
        seg3_out  <= 7'b0000000;
        seg4_out  <= 7'b0000000;
    end else begin
        case (state)
            IDLE: begin
                leds_out  <= 10'b1000000000;
                seg0_out  <= 7'b0000000;
                seg1_out  <= 7'b0000000;
                seg2_out  <= 7'b0000000;
                seg3_out  <= 7'b0000000;
                seg4_out  <= 7'b0000000;
            end
            digit_2: begin
                leds_out  <= 10'b1100000000;
                seg0_out  <= 7'b1111111;
                seg1_out  <= 7'b0010010;
                seg2_out  <= 7'b1111111;
                seg3_out  <= 7'b1111111;
                seg4_out  <= 7'b1111111;
            end
            digit_3: begin
                leds_out  <= 10'b1110000000;
                seg0_out  <= 7'b1111111;
                seg1_out  <= 7'b0010010;
                seg2_out  <= 7'b0000001;
                seg3_out  <= 7'b1111111;
                seg4_out  <= 7'b1111111;
            end
            digit_4: begin
                leds_out  <= 10'b1111000000;
                seg0_out  <= 7'b1111111;
                seg1_out  <= 7'b0010010;
                seg2_out  <= 7'b0000001;
                seg3_out  <= 7'b1001111;
                seg4_out  <= 7'b1111111;
            end
            done: begin
                leds_out  <= 10'b1111100000;
                seg0_out  <= 7'b1111111;
                seg1_out  <= 7'b1000010;
                seg2_out  <= 7'b0000001;
                seg3_out  <= 7'b0001001;
                seg4_out  <= 7'b0110000;
            end
            error: begin
                leds_out  <= 10'b0000000000;
                seg0_out  <= 7'b0110000;
                seg1_out  <= 7'b1111010;
                seg2_out  <= 7'b1111010;
                seg3_out  <= 7'b1100010;
                seg4_out  <= 7'b1111010;
            end
            default: begin
                leds_out  <= 10'b0000000000;
                seg0_out  <= 7'b0000000;
                seg1_out  <= 7'b0000000;
                seg2_out  <= 7'b0000000;
                seg3_out  <= 7'b0000000;
                seg4_out  <= 7'b0000000;
            end
        endcase
    end
end

endmodule
