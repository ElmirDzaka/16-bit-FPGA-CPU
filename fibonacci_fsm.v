// Module for the Fibonacci sequence
// Created by Louis J. Cerda on 9/23/2021
// Fibonacci sequnce for reference
// 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144

// ns Logic: Next state transitions


module fibonacci_fsm (clk, reset, immediate, buff_en, enable, control1, control2, imm_control, opcode);

	// Input signals for the FSM
	input clk, reset;
	
	// Enable signals for the data flow
	output reg [15:0] immediate;
   output reg buff_en;
   output reg [15:0]enable;
	output reg [4:0]control1;
	output reg [4:0]control2;
	output reg imm_control;
	output reg [7:0]opcode;

	
	// ps -> Previous state, ns -> Next state
	reg [3:0] ps, ns; 
	
	
	parameter [3:0] s0  = 4'b0000;
   parameter [3:0] s1  = 4'b0001;
   parameter [3:0] s2  = 4'b0010;
   parameter [3:0] s3  = 4'b0011;
   parameter [3:0] s4  = 4'b0100;
   parameter [3:0] s5  = 4'b0101;
   parameter [3:0] s6  = 4'b0110;
   parameter [3:0] s7  = 4'b0111;
   parameter [3:0] s8  = 4'b1000;
   parameter [3:0] s9  = 4'b1001;
	parameter [3:0] s10 = 4'b1010;
	parameter [3:0] s11 = 4'b1011;
	parameter [3:0] s12 = 4'b1100;



	
	
	//Sequential block, negedge of reset due to push button
	always @ (posedge clk, posedge reset) begin

		if(reset== 1) ps <= s0;
		else ps <= ns;

	end
	
	// Combinational block, responsible fo setting the next state
	always@(posedge clk, negedge reset) begin

		case(ps)
			s0: ns <= s1;
   		s1: ns <= s2;
			s2: ns <= s3;
			s3: ns <= s4;
			s4: ns <= s5;
			s5: ns <= s6;
			s6: ns <= s7;
			s7: ns <= s8;
			s8: ns <= s9;
			s9: ns <= s9;
			s10:ns <= s11;
			s11:ns <= s12;
			
			
			default: ns <= s0;
		endcase
	end


	always@ (ps) begin

		case(ps)
			// Reset muxes, and tristate to 0. 
			// Template for the FSM enable codes
			s0: begin  
					immediate   = 0;  //Incoming Immediate value              [15:0]
					enable      = 0;  //Register enable 							 [15:0]
					opcode      = 0;	//Operation code for ALU	             [7: 0]
					control1    = 0;  //control code for mux on the left      [4: 0]
					control2    = 0;  //control code for mux on the right     [4: 0]
					imm_control = 0;  //control code for immediate value      [1bit]
					buff_en     = 0;  //enable signal for ALU output          [1bit]
				end
				
			// Load value into left register from r0 into ALU
			s1: begin  
					immediate   = 0;  
					enable      = 0;                
					opcode      = 0;	
					control1    = 5'b00001;              // enable left mux
					control2    = 0;  
					imm_control = 0;  
					buff_en     = 0;  
				end
				
			// Load value from immediate into ALU
			s2: begin  
					immediate   = 16'b0000000000000001; // Load 1 from immediate
					enable      = 0;  
					opcode      = 0;	
					control1    = 0;  
					control2    = 0;  
					imm_control = 1;                    // Enable immediate value  
					buff_en     = 0;  
				end
			
			// Compute 0+1 and write into r1
			s3: begin  
					immediate   = 16'b0000000000000001; // hold 1 from immediate
					enable      = 16'b0000000000000010; // enable r1 to write into
					opcode      = 8'b00000101;	         // add op
					control1    = 0;  
					control2    = 0;  
					imm_control = 1;                    // hold immediate value  
					buff_en     = 1;                    // allow data onto bus
				end 
			
			
			
			
			
			// r0=0, r1=1
			
			
			// Load value into left register from r1 into ALU
			s4: begin  
					immediate   = 0;  
					enable      = 0;                
					opcode      = 0;	
					control1    = 5'b00010;             // load value from r1 into left mux
					control2    = 0;  
					imm_control = 0;  
					buff_en     = 0;  
				end
			
			// Load value into right register from r0 into ALU
			s5: begin  
					immediate   = 0;                
					enable      = 0;  
					opcode      = 0;	
					control1    = 0;  
					control2    = 5'b00001;             // load value from r0 into right mux
					imm_control = 0;                 
					buff_en     = 0;  
				end
				
			// Compute 0+1.... again and write into r2
			s6: begin  
					immediate   = 0;
					enable      = 16'b0000000000000100; // enable r2 to write into
					opcode      = 8'b00000101;	         // add op
					control1    = 0;  
					control2    = 0;  
					imm_control = 0;         
					buff_en     = 1;                    // allow data onto bus
				end 
			
			
			// r0=0, r1=1, r2=1
			
			// Load value into left register from r2 into ALU
			s7: begin  
					immediate   = 0;  
					enable      = 0;                
					opcode      = 0;	
					control1    = 5'b00011;              // enable left mux
					control2    = 0;  
					imm_control = 0;  
					buff_en     = 0;  
				end
				
			// Load value into right register from r1 into ALU	
			s8: begin  
					immediate   = 0;                
					enable      = 0;  
					opcode      = 0;	
					control1    = 0;  
					control2    = 5'b00010;             // load value from r0 into right mux
					imm_control = 0;                 
					buff_en     = 0;  
				end

			// Compute 1+1.... again and write into r3
			s9: begin  
					immediate   = 0;
					enable      = 16'b0000000000001000; // enable r3 to write into
					opcode      = 8'b00000101;	         // add op
					control1    = 0;  
					control2    = 0;  
					imm_control = 0;         
					buff_en     = 1;                    // allow data onto bus
				end 
				
			// r0=0, r1=1, r2=1, r3=2 
			
			
			// Load value into left register from r3 into ALU
			s10: begin  
					immediate   = 0;  
					enable      = 0;                
					opcode      = 0;	
					control1    = 5'b00100;              // enable left mux
					control2    = 0;  
					imm_control = 0;  
					buff_en     = 0;  
				end 
			
			// Load value into right register from r2 into ALU	
			s11: begin  
					immediate   = 0;                
					enable      = 0;  
					opcode      = 0;	
					control1    = 0;  
					control2    = 5'b00011;             // load value from r0 into right mux
					imm_control = 0;                 
					buff_en     = 0;  
				end
				
			// Compute 1+2 and write into r4
			s12: begin  
					immediate   = 0;
					enable      = 16'b0000000000001000; // enable r4 to write into
					opcode      = 8'b00000101;	         // add op
					control1    = 0;  
					control2    = 0;  
					imm_control = 0;         
					buff_en     = 1;                    // allow data onto bus
				end 
				
				
			
			// r0=0, r1=1, r2=1, r3=2, r4=3

			
			default: begin
					immediate   = 0;  //Incoming Immediate value              [15:0]
					enable      = 0;  //Register enable 							 [15:0]
					opcode      = 0;	//Operation code for ALU	             [7: 0]
					control1    = 0;  //control code for mux on the left      [4: 0]
					control2    = 0;  //control code for mux on the right     [4: 0]
					imm_control = 0;  //control code for immediate value      [1bit]
					buff_en     = 0;  //enable signal for ALU output          [1bit]
           end
	
		
		
		
		
		endcase
	end
endmodule	
			
	

	