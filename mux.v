module mux(bus, control, out);

input [15:0] bus;
input control;
output reg [15:0] out;

always @(control) begin
	if(control)
		out = 16'bz;
	else
		out = bus;

end
endmodule 