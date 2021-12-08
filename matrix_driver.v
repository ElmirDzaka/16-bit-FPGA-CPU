//Program counter for the led matrix
module matrix_driver (raw_instruction, out); 

	input [15:0] raw_instruction;
	output reg[15:0] out;
	
	always @(raw_instruction) begin
		out = raw_instruction;
	end
	
endmodule

