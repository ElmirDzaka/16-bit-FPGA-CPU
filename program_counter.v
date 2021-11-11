module program_counter(in_pc, en_pc, pc_result, reset, clk); //make sure all flags are defined in all cases
input clk;
input [15:0] in_pc;
input en_pc;
input reset;  // Maybe reset not needed
output reg [15:0] pc_result; // Maybe not 16 bits



always @(en_pc, reset)
	begin
	// If reset. Reset the program counter to 0.
	if (!reset) begin
	pc_result = 0; 
	end
	else
		begin

			// If Enable is on. Take the incoming program counter value
			if (en_pc)
				begin
					pc_result <= in_pc;
				end
			// Else, continue with the same program counter	
			else
				begin
					pc_result <= pc_result;
				end
		end
	end
endmodule

