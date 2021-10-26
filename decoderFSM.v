// Decoder Verilog File
// Created By Louis J. Cerda
//
// Module contract decoder:
// in :       Incoming instruction from Ram
// reset:     Reset signal to reset FSM???
// out:        

module decoderFSM(clk, in, reset, immediate, enable, opcode, control1, control2, imm_control, buff_en, en_pc, pc_mux_en); //make sure all flags are defined in all cases
	
	// I/0 parameters
	input  clk;
	input       [15:0] in;
	//output reg [15:0] out;
	reg        [7:0] copcode;
	reg        [7:0] copcode2;
	reg        [3:0] rdst;
	reg        [3:0] rsrc;
	reg        [3:0] rdst2;
	reg        [3:0] rsrc2;
	input      reset;

	// Enables signals
	output reg [15:0] immediate;
	output reg [15:0]enable;
	output reg [7:0]opcode;
   output reg [4:0]control1;
   output reg [4:0]control2;
   output reg imm_control;
	output reg buff_en;
	output reg en_pc;
	output reg pc_mux_en;


   // ======================== State Machine Code =========================//
	
	// ps -> Previous state, ns -> Next state
   reg [3:0] ps, ns; 
    
   //Need to add more state parameters as needed
   parameter [3:0] s0  = 4'b0000;
   parameter [3:0] s1  = 4'b0001;
   parameter [3:0] s2  = 4'b0010;
   parameter [3:0] s3  = 4'b0011;
   parameter [3:0] s4  = 4'b0100;
	parameter [3:0] s5  = 4'b0101;

       
    //Sequential block, negedge of reset due to push button
    always @ (negedge clk) begin

        ps <= ns;

    end
    
    // Combinational block, responsible fo setting the next state
    always@(posedge clk, negedge reset) begin
		if(reset == 0) begin    
			ns = s0;
		end
		 
		 
		else begin
			// Need to add more stepping
        case(ps)
           s0: begin
					  ns <= s1;  // EDIT changed s1: ns <= si  to s0: ns <= si
					  copcode2 <= in [15:8];
						
						// Fetch Rdest and Rsrc
						rdst2 = in[7:4];
						rsrc2 = in[3:0];
						end
			  s1: begin
			  				case(copcode2)
						// add
						8'b00000101 : ns = s2;
						//addu
						8'b00000110 : ns = s2;
						//addc
						8'b00000111 : ns = s2;
						//sub
						8'b00001001 : ns = s2;
						//cmp
						8'b00001011 : ns = s2;
						//AND
						8'b00000001 : ns = s2;
						//Or
						8'b00000010 : ns = s2;
						//xor
						8'b00000011 : ns = s2;
						//lsh
						8'b10000100 : ns = s2;
						//rsh
						8'b00001000 : ns = s2;
						//alsh
						8'b00001100 : ns = s2;
						//arsh
						8'b00001111 : ns = s2;
						//not
						8'b00000100 : ns = s2;				
				endcase
				end
			  s2: ns <= s3;
			  s3: ns <= s4;
			  s4: ns <= s5;
			  s5: ns <= s5;

           default: ns <= s0;
        endcase
		end
    end

	// ======================== State Machine Code =========================//

	
	
	// Fetch the first 8 bits 
	
	
	
	// Checking R-type
   // Register mode (R-Types instructions): compulsory
	
		


	always @(ps) begin // SAMQ
		case(ps)
		
			// s0: Fetch stage
			s0: begin
			
				// Fetch the Opcode, which is the first 8 bits
				copcode <= in [15:8];
				
				// Fetch Rdest and Rsrc
				rdst = in[7:4];
				rsrc = in[3:0];
    
				// Reset all the enables to 0
				en_pc       = 0;
				pc_mux_en   = 0;
				immediate   = 16'b0000000000000000; 
				enable      = 0;              
            opcode      = 0; 
				control1    = 0;
            control2    = 0; 
            imm_control = 0;                    
            buff_en     = 0; 
			end
			
			
			
			// s1: Decode stage (figure out type of instruction)
			s1: begin
			
				// R Types instructions. Checks to see if the opcode is present
//				case(copcode)
//						// add
//						8'b00000101 : ns = s2;
//						//addu
//						8'b00000110 : ns = s2;
//						//addc
//						8'b00000111 : ns = s2;
//						//sub
//						8'b00001001 : ns = s2;
//						//cmp
//						8'b00001011 : ns = s2;
//						//AND
//						8'b00000001 : ns = s2;
//						//Or
//						8'b00000010 : ns = s2;
//						//xor
//						8'b00000011 : ns = s2;
//						//lsh
//						8'b10000100 : ns = s2;
//						//rsh
//						8'b00001000 : ns = s2;
//						//alsh
//						8'b00001100 : ns = s2;
//						//arsh
//						8'b00001111 : ns = s2;
//						//not
//						8'b00000100 : ns = s2;				
//				endcase
				
				
				//TODO Else its immediate instruction
				// ns s3
			end
			
			// s2: Execute + write back for R-type instructions
			s2: begin
				en_pc       = 0;
            pc_mux_en   = 0;
            immediate   = 16'b0000000000000000; 
				//TODO if code isnt working check here
            if(copcode == 8'b00001011) begin
					enable = 16'bx;
				end 
				else begin 
					enable      = rdst; 
				end 
            opcode      = copcode; 
            control1    = rdst + 1;
            control2    = rsrc + 1; 
            imm_control = 0;
            buff_en     = 1;
		   end
		endcase
	end	
endmodule 