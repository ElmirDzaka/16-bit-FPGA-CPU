module pc_immediate_mux(immediate, pc_mux_en, data_in, out);

input [9:0] immediate; // some immediate jump instruction / displacement
input pc_mux_en;       // eng
input [9:0] data_in;  // bram
output reg [9:0] out; // goes into pc




always @(pc_mux_en, immediate, data_in) begin
	// If control is present, Select the program counter + displacement
	if(pc_mux_en) begin
		out = immediate; //Address for memory
	end
	// Else, Select program counter +1
	else begin
		out = data_in + immediate; // PC + Displacement
	end
		
		
end
endmodule
