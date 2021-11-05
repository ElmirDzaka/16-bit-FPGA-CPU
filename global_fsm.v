// Code for the FSM
module global_fsm(clk, reset,  we_enable, opcode_in ,rdst_in ,rsrc_in ,immediate_in, immediate_out, pc_mux_en, rdst_out, rsrc_out, flags, flag_type, pc_en, flag_enable, imm_mux, tristate_en, opcode_out, IR_enable, ls_control , rdst_write_out, rdst_write_in, state_output); // NOTE include LS contorl.

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
	output reg [3:0] state_output;
	
	
	
	
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
	parameter [3:0] s6  = 4'b0110;
	
	
	//Sequential block, negedge of reset due to push button
    always @ (negedge clk) begin

        ps <= ns;

    end
	

	
	// Combinational block, responsible for setting the next state
   always@(posedge clk, negedge reset) begin
		if(reset == 0) begin    
			ns = s0;
		end
    
	 
		else begin
        case(ps)
           s0: begin
			  ns <= s1;
			  end
			
			  s1: begin
					// Checking for r-type
					if(flag_type == 4'b0001) begin
						ns <= s2;
					end
				
					// Checking for store
					else if(flag_type == 4'b0101) begin
						ns = s3;
					end
				
					// Checking for load
					else  begin
						if(flag_type == 4'b0100) begin 
							ns = s4;
						end		
					end
				end
				
				
				s2: begin
					ns <= s0;
				end
				
				s3: begin
					ns <= s0;
				end
				
				s4: begin
					ns <= s5;
				end
				
				s5: begin
					ns <= s0;
				end
        endcase
    end
	end
	 
	 // This always block handles the enable signals
	 always@ (ps) begin
	 
	  state_output = ps; // REMOVE

	 
		case(ps)
			s0: begin
				// 1 bit enable signals 
				pc_en       = 0; // 1: Updates PC              
				pc_mux_en   = 0; // 1: Pick Displacement
				flag_enable = 0; // 1: Update flags
				imm_mux     = 0; // 1: Pick immediate
				tristate_en = 0; // 1: Pass signal to bus
				we_enable   = 0; // 1: Enables ram?
				IR_enable   = 0; // 1: Updates enable
				ls_control  = 0; // 1: Pick immediate store
			
				// Read and write for regbank
				rdst_write_out = 16'bx; // reg bank write enable
				rsrc_out       = 5'bx;  // mux a load control
				rdst_out       = 5'bx;  // mux b load control
			
            // Operations
				opcode_out     = 8'bx; // ALU Control
	         immediate_out  = 8'bx; // Immediate value (external source)
			end
			
			s1: begin  // For r-type instructions

			
				// 1 bit enable signals 
				pc_en       = 0; // 1: Updates PC              
				pc_mux_en   = 0; // 1: Pick Displacement
				flag_enable = 0; // 1: Update flags
				imm_mux     = 0; // 1: Pick immediate
				tristate_en = 0; // 1: Pass signal to bus
				we_enable   = 0; // 1: Enables ram?
				IR_enable   = 0; // 1: Updates enable
				ls_control  = 0; // 1: Pick immediate store
			
				// Read and write for regbank
				rdst_write_out = 16'bx; // reg bank write enable
				rsrc_out       = 5'bx;  // mux a load control
				rdst_out       = 5'bx;  // mux b load control
			
            // Operations
				opcode_out     = 8'bx; // ALU Control
	         immediate_out  = 8'bx; // Immediate value (external source)
			end
			
			s2: begin
			
			// 1 bit enable signals 
				pc_en       = 0; // 1: Updates PC              
				pc_mux_en   = 0; // 1: Pick Displacement
				flag_enable = 0; // 1: Update flags
				imm_mux     = 0; // 1: Pick immediate
				tristate_en = 0; // 1: Pass signal to bus
				we_enable   = 0; // 1: Enables ram?
				IR_enable   = 1; // 1: Updates enable
				ls_control  = 0; // 1: Pick immediate store
			
				// Read and write for regbank
				rdst_write_out = 16'bx; // reg bank write enable
				rsrc_out       = rsrc_in;  // mux a load control
				rdst_out       = rdst_in;  // mux b load control
			
            // Operations
				opcode_out     = opcode_in; // ALU Control
	         immediate_out  = 8'bx; // Immediate value (external
			end
			
			
			//store
            //TODO switch rsrc and rdst? I did switch it
			s3: begin // ask saeed 3, 4 ,5
			
			
                     // 1 bit enable signals 
                pc_en       = 1; // 1: Updates PC
                pc_mux_en   = 0; // 1: Pick Displacement
                flag_enable = 0; // 1: Update flags
                imm_mux     = 0; // 1: Pick immediate
                tristate_en = 0; // 1: Pass signal to bus
                we_enable   = 1; // 1: Enables ram?
                IR_enable   = 0; // 1: Updates enable
                ls_control  = 0; // 1: Pick immediate store

                // Read and write for regbank
                rdst_write_out = 16'bx; // reg bank write enable
                rsrc_out       = rdst_in;  // mux a load control
                rdst_out       = rsrc_in;  // mux b load control

            // Operations
                opcode_out     = opcode_in; // ALU Control
                     immediate_out  = 8'bx; // Immediate value (external source)
			
			end
			
			s4: begin
				      // 1 bit enable signals 
                pc_en       = 0; // 1: Updates PC
                pc_mux_en   = 0; // 1: Pick Displacement
                flag_enable = 0; // 1: Update flags
                imm_mux     = 0; // 1: Pick immediate
                tristate_en = 0; // 1: Pass signal to bus
                we_enable   = 0; // 1: Enables ram?
                IR_enable   = 1; // 1: Updates enable
                ls_control  = 1; // 1: Pick immediate store

                // Read and write for regbank
                rdst_write_out = 16'bx; // reg bank write enable
                rsrc_out       = rsrc_in;  // mux a load control
                rdst_out       = 5'bx;  // mux b load control

            // Operations
                opcode_out     = opcode_in; // ALU Control
                     immediate_out  = 8'bx; // Immediate value (external source)
            
			
			end
			
			s5: begin
			
		                             // 1 bit enable signals 
                pc_en       = 1; // 1: Updates PC
                pc_mux_en   = 0; // 1: Pick Displacement
                flag_enable = 0; // 1: Update flags
                imm_mux     = 0; // 1: Pick immediate
                tristate_en = 1; // 1: Pass signal to bus
                we_enable   = 0; // 1: Enables ram?
                IR_enable   = 1; // 1: Updates enable
                ls_control  = 1; // 1: Pick immediate store

                // Read and write for regbank
                rdst_write_out = 16'bx; // reg bank write enable
                rsrc_out       = rsrc_in;  // mux a load control
                rdst_out       = 5'bx;  // mux b load control

            // Operations
                opcode_out     = opcode_in; // ALU Control
                     immediate_out  = 8'bx; // Immediate value (external source)
            
			
			
			end
			
			s6: begin
			// 1 bit enable signals 
				pc_en       = 0; // 1: Updates PC              
				pc_mux_en   = 0; // 1: Pick Displacement
				flag_enable = 0; // 1: Update flags
				imm_mux     = 1; // 1: Pick immediate
				tristate_en = 1; // 1: Pass signal to bus
				we_enable   = 0; // 1: Enables ram?
				IR_enable   = 1; // 1: Updates enable
				ls_control  = 0; // 1: Pick immediate store
			
				// Read and write for regbank
				rdst_write_out = 16'bx; // reg bank write enable
				rsrc_out       = rsrc_in;  // mux a load control
				rdst_out       = rdst_in;  // mux b load control
			
            // Operations
				opcode_out     = opcode_in; // ALU Control
	         immediate_out  = 8'bx; // Immediate value (external source)
			
				
			end
			
		endcase
	end
endmodule 