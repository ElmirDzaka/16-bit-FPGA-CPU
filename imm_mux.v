module imm_mux(immediate, control, data_in, out);

input [15:0] immediate;
input control;
input [15:0] data_in;
output reg [15:0] out;



always @(control) begin
	if(control) begin
		out = immediate;
	end
	else begin
		out = data_in;
	end
		
		
		

end
endmodule
