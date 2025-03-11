module clkdiv#(parameter CONST_N = 50000)(
	input clk, rst,
	output reg clk_div
	);
	
reg [ceillog2(CONST_N) - 1 : 0] count;

always @(posedge(clk), negedge(rst))
begin
	if(~rst)
		count <= 0;
	else if (count == CONST_N-1)
		count <= 0;
	else 
		count <= count + 1;
end
	
always @(posedge(clk), negedge(rst))
begin
	if(~rst)
		clk_div <= 0;
	else if (count == CONST_N -1)
		clk_div <= ~clk_div;
	else
		clk_div <= clk_div;
end

/*log function*/
function integer ceillog2;
	input integer data;
	integer i, result;
	begin
		for (i=0; 2**i < data; i=i+1)
			result = i + 1;
		ceillog2 = result;
	end
endfunction


endmodule