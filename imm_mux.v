module imm_mux(immediate, control, data_in, out);

input [15:0] immediate;
input control;
input [15:0] data_in;
output reg [15:0] out;



//always @(control, immediate) begin
//	if(control) begin
//		out = immediate;
//	end
//	else begin
//		out = data_in; // do nothing
//	end
		
		always @(*) begin
		
			out = control ? immediate : data_in;
			
			
		
		

end
endmodule
