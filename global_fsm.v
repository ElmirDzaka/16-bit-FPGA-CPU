// Code for the FSM
module global_fsm(clk, reset,  we_enable, opcode_in ,rdst_in ,rsrc_in ,immediate_in, immediate_out, pc_mux_en, rdst_out, rsrc_out, flags, flag_type, pc_en, flag_enable, imm_mux, tristate_en, opcode_out, IR_enable, ls_control , rdst_write_out, rdst_write_in); // NOTE include LS contorl.

	// Global Clock and Reset
	input clk;
	input reset;
	
	// Read and write for regbank
	input [15:0] rdst_write_in;  // Reg bank write enable
	input [4:0] rsrc_in;         // mux a load control
	input [4:0] rdst_in;         // mux b load control

	

	// Flags
	input [7:0] flags;
	input [3:0] flag_type;
	
	// Operations
	input [7:0] immediate_in;
	input [7:0] opcode_in;
	
	// 1 bit enable signals 
	output reg pc_en;
	output reg pc_mux_en; 
	output reg flag_enable; 
	output reg imm_mux; 
	output reg tristate_en;
	output reg we_enable;
	output reg IR_enable;
	output reg ls_control;
	
	
	// Read and write for regbank
	output reg [15:0] rdst_write_out; // reg bank write enable
	output reg [4:0]  rsrc_out;       // mux a load control
	output reg [4:0]  rdst_out;       // mux b load control
	
	
	// Operations
	output reg [7:0] opcode_out;
	output reg [7:0] immediate_out;
	


		
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
				IR_enable          = 0;
				imm_mux       = 0;
				tristate_en   = 0;
				we_enable     = 0;
				flag_enable    =0;
				rdst_out      = 16'bx;
				rsrc_out      = 5'bx;
				opcode_out    = 8'bx;
				immediate_out = 8'bx;
			end
			
			// For r-type instructions
			s1: begin
			   pc_en         = 0;
				pc_mux_en     = 0;
				IR_enable          = 1; // save instruction
				imm_mux       = 0;
				tristate_en   = 1;
				we_enable    = 0;
				flag_enable   = 0;
				rdst_out      = rdst_in;
				rsrc_out      = rsrc_in;
				opcode_out    = opcode_in;
				immediate_out = 8'bx;
		
			end
			
			s2: begin
			
			
			end
			
			s3: begin // ask saeed 3, 4 ,5
			
			end
			
			s4: begin
			
			
			end
			
			s5: begin
			
			
			end
		endcase
	end
endmodule 