module tristatebuffer(inp, en, out);

input [15:0] inp;
input en;

output wire [15:0] out;

assign out = en?inp:16'bx;

endmodule
