module pc_mux(immediate, pc_mux_en, data_in, out);

input [15:0] immediate;
input pc_mux_en;
input [15:0] data_in;
output reg [15:0] out;




always @(pc_mux_en, immediate) begin
	// If control is present, Select the program counter + displacement
	if(pc_mux_en) begin
		out = immediate;
	end
	// Else, Select program counter +1
	else begin
		out = data_in; 
	end
		
		
end
endmodule
