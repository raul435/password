module verificador (
    input rst, clk, 
    input [9:0] Sw,
    output reg [3:0] status_out
);

parameter IDLE = 0;
parameter digit_2 = 1;
parameter digit_3 = 2;
parameter digit_4 = 3;
parameter done = 4;
parameter error = 5;

reg [3:0] state;
reg [3:0] state_next;

always @(posedge clk or negedge rst)
begin
    if (!rst)
        state <= IDLE;
    else
        state <= state_next;
end

always @(*) begin
    state_next = state;
    case (state)
        IDLE:
            if (Sw == 10'b0000000100)  // Solo Sw[2] en 1
                state_next = digit_2;
            else if (Sw != 0)
                state_next = error;
        digit_2:
            if (Sw == 10'b0000000001)  // Solo Sw[0] en 1
                state_next = digit_3;
            else if (Sw != 0)
                state_next = error;
        digit_3:
            if (Sw == 10'b0000000010)  // Solo Sw[1] en 1
                state_next = digit_4;
            else if (Sw != 0)
                state_next = error;
        digit_4:
            if (Sw == 10'b0001000000)  // Solo Sw[6] en 1
                state_next = done;
            else if (Sw != 0)
                state_next = error;
        done:
            state_next = done;
        error:
            state_next = error;
    endcase
end

always @(state)
begin
    status_out = state;
end

endmodule
