module mux(bus, control, out);

input [3:0] bus;
input control;
output reg [3:0] out;

always @(control) begin
	if(control)
		out = 4'b0011;
	else
		out = bus;

end
endmodule 