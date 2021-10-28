// Code for the FSM
module global_fsm(clk, reset,  ram_enable, opcode_in ,rdst_in ,rsrc_in ,immediate_in, immediate_out, pc_mux_en, rdst_out, rsrc_out, flags, flag_type, pc_en, r_en, imm_mux, tristate_en, opcode_out); // NOTE include LS contorl.

	input clk;
	input reset;
	input [15:0] rdst_in;     // 4 bits ----> 16 bits  // 1111 -. 15'b100000000000000 enable to write
	                         // To read regbank its 5bits, to write 16 bit
									 
									 // Decoder 4 bits 
	
	
	input [4:0] rsrc_in;
	input [3:0] flag_type;
	input [7:0] immediate_in;
	input [7:0] opcode_in;
	input [7:0] flags;
	
	output reg pc_en;
	output reg pc_mux_en;
	output reg r_en; //  flag enable
	output reg imm_mux;
	output reg tristate_en;
	output reg ram_enable;
	output reg [15:0] rdst_out;
	output reg [4:0] rsrc_out;
	output reg [7:0] opcode_out;
	output reg [7:0] immediate_out;


	
	//Note missing LS control


	
	// ps -> Previous state, ns -> Next state
   reg [3:0] ps, ns; 
	
	//Need to add more state parameters as needed
   parameter [3:0] s0  = 4'b0000; //Global Reset stage
   parameter [3:0] s1  = 4'b0001;
   parameter [3:0] s2  = 4'b0010;
   parameter [3:0] s3  = 4'b0011;
   parameter [3:0] s4  = 4'b0100;
	parameter [3:0] s5  = 4'b0101;
	
	// Combinational block, responsible for setting the next state
   always@(posedge clk, negedge reset) begin
		if(reset == 0) begin    
			ns = s0;
		end
    
		else begin
        case(ps)
           s0: ns <= s1;
			
			  s1: begin
				// Checking for r-type
				if(flag_type == 4'b0001) begin
					ns <= s2;
					ns <= s0;
				end
				
				// Checking for load
				else if(flag_type == 4'b0010) begin
					ns <= s3;
					ns <= s0;
				end
				
				// Checking for store
				else if(flag_type == 4'b0100) begin
					ns <= s4;
					ns <= s5;
					ns <= s0;
				end
				
				// Checking for -------
				else if(flag_type == 4'b1000) begin
					// ----
				end
				
				// Should never hit this state. Only in place to avoid latches
				else begin
					ns <= s0;
				end
			  end
			  
           default: ns <= s0; // Should never hit this. Here for now maybe gone later
        endcase
		end
    end
	 
	 // This always block handles the enable signals
	 always@ (ps) begin
		case(ps)
			s0: begin
				pc_en         = 0;
				pc_mux_en     = 0;
				r_en          = 0;
				imm_mux       = 0;
				tristate_en   = 0;
				ram_enable     = 0;
				rdst_out      = 16'bx;
				rsrc_out      = 5'bx;
				opcode_out    = 8'bx;
				immediate_out = 8'bx;
			end
			
			// For r-type instructions
			s1: begin
			   pc_en         = 0;
				pc_mux_en     = 0;
				r_en          = 1; // save instruction
				imm_mux       = 0;
				tristate_en   = 1;
				ram_enable    = 0;
				rdst_out      = rdst_in;
				rsrc_out      = rsrc_in;
				opcode_out    = opcode_in;
				immediate_out = 8'bx;
		
			end
			
			s2: begin
			
			
			end
			
			s3: begin
			
			end
			
			s4: begin
			
			
			end
			
			s5: begin
			
			
			end
		endcase
	end
endmodule 