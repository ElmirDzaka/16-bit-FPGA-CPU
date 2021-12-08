//Program counter for the led matrix
module pc_matrix (clk, reset_arduino, pc_result, enable); 
input enable;
input clk;
input reset_arduino;  // Maybe reset not needed
output reg [15:0] pc_result; // Maybe not 16 bits


parameter [15:0] min_value =16'b0000000000000000; // 1. The start of memory for game board

parameter [15:0] max_value =16'b0000000011111111; // 12. The end of memory for game board


always @(posedge enable, negedge reset_arduino) begin //originally en_pc, reset begi
		
		if (!reset_arduino) begin
			pc_result = min_value; 
		end
		
		// When it reaches EOF reset to beggining
		else if(pc_result == max_value) begin
			pc_result = min_value;
			// create a wait maybe?
		end
		
		// Otherwise increment by 1
		else begin
			
			pc_result = pc_result + 16'b0000000000000001;
			
		end
end


endmodule

