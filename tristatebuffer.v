module tristatebuffer(inp, en, out);

input [15:0] inp;
input en;

output reg [15:0] out;

//assign out = en?inp:16'bx;
always @(inp, en) begin
		 out = en?inp:16'bx;
end

endmodule
