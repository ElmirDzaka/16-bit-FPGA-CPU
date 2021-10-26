// Module for the Fibonacci sequence
// Created by Louis J. Cerda on 9/23/2021
// Fibonacci sequnce for reference
// 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144

// ns Logic: Next state transitions

module fsm_decoder(in, out, reset, clk, immediate, enable, opcode, control1, control2, imm_control, buff_en, en_pc, pc_mux_en, type);

    // I/0 parameters
	input       [15:0] in;
	output reg [15:0] out;
	reg        [7:0] copcode;  
	reg        [3:0] rdst;
	reg        [3:0] rsrc;
	input      reset;
	input		  clk;
	

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
	output reg type;
    
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
			//add if statments to determine where next state is / check slides
        case(ps)
           s0: ns <= s1;  // EDIT changed s1: ns <= si  to s0: ns <= si
			  s1: ns <= s2;
			  s2: ns <= s3;
			  s3: ns <= s4;
			  s4: ns <= s5;
			  s5: ns <= s5;

           default: ns <= s0;
        endcase
		end
    end


    always@ (ps) begin

        case(ps)
            // Reset all registers, muxes,tri-state-buffer
				//Step 0 : 
            s0: begin  
                    en_pc = 0;
						  pc_mux_en = 0;
						  enable = 0;
						  control1 = 5'bx;
						  control2 = 5'bx;
						  opcode = 0;
						  type = 1'bx;
						  immediate = 16'bx;	
						  imm_control = 1'bx;
						  buff_en = 1'bx;
                end
                
            // Step 1: R1 = 0+1 = 1
            s1: begin  
                             
                end
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
				 // Step 2: R2 = 0+1 = 1
            s2: begin  
                    immediate   = 16'b0000000000000001; 
                    enable      = 16'b0000000000000100;//r2                
                    opcode      = 8'b00000101;                     
                    control1    = 5'b00001;//r0             // enable left mux
                    control2    = 5'b00010;//r1 
                    imm_control = 0;                    
                    buff_en     = 1;    
                end
					 
					 
				 // Step 3: R3 = 1+1 = 2
            s3: begin  
                    immediate   = 0; 
                    enable      = 16'b0000000000001000;//r3                 
                    opcode      = 8'b00000101;                     
                    control1    = 5'b00010; //r1            // enable left mux
                    control2    = 5'b00011; //r2 
                    imm_control = 0;                    
                    buff_en     = 1;    
                end
					 
				// Step 4: R4 = 1+2 = 3
				s4: begin  
                    immediate   = 0; 
                    enable      = 16'b0000000000010000;//r4                 
                    opcode      = 8'b00000101;                     
                    control1    = 5'b00011;//r2            // enable left mux
                    control2    = 5'b00100;//r3  
                    imm_control = 0;                    
                    buff_en     = 1;    
                end
				
				// Step 5: R5 = 3+2 = 5
				s5: begin  
                    immediate   = 0; 
                    enable      = 16'b0000000000100000;//r5                 
                    opcode      = 8'b00000101;                     
                    control1    = 5'b00100;//r3             // enable left mux
                    control2    = 5'b00101;//r4 
                    imm_control = 0;                    
                    buff_en     = 1;    
                end
                            
        endcase
    end
endmodule