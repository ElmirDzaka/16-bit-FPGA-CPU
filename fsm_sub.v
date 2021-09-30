module fsm_sub (clk, reset, immediate, buff_en, enable, control1, control2, imm_control, opcode);

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
            //reset all enables to 0
			 s0: begin  
                    immediate   = 0;  //Incoming Immediate value              [15:0]
                    enable      = 0;  //Register enable                       [15:0]
                    opcode      = 0;  //Operation code for ALU                [7: 0]
                    control1    = 0;  //control code for mux on the left      [4: 0]
                    control2    = 0;  //control code for mux on the right     [4: 0]
                    imm_control = 0;  //control code for immediate value      [1bit]
                    buff_en     = 0;  //enable signal for ALU output          [1bit]
                end
			 
			 // Step 1: R1 = 0+10 = 10
            s1: begin  
                    immediate   = 16'b0000000000001010; 
                    enable      = 16'b0000000000000010;//r1                 
                    opcode      = 8'b00000101;                     
                    control1    = 5'b00001;//r0             // enable left mux
                    control2    = 0;     
                    imm_control = 1;       //immediate               
                    buff_en     = 1;                    
                end
					 
					// R2 = r1 - 1 = 9
            s2: begin  
                    immediate   = 16'b0000000000000001; 
                    enable      = 16'b0000000000000100;//r2                 
                    opcode      = 8'b00001001;                     
                    control1    = 5'b00010;//r1             // enable left mux
                    control2    = 0;     
                    imm_control = 1;       //immediate               
                    buff_en     = 1;                    
                end
					 
					 	// R3 = r2 - 1 = 8
            s3: begin  
                    immediate   = 16'b0000000000000001; 
                    enable      = 16'b0000000000001000;//r3                 
                    opcode      = 8'b00001001;                     
                    control1    = 5'b00011;//r2             // enable left mux
                    control2    = 0;     
                    imm_control = 1;       //immediate               
                    buff_en     = 1;                    
                end
			 
			 // R4 = r3 - 1 = 7
            s4: begin  
                    immediate   = 16'b0000000000000001; 
                    enable      = 16'b0000000000010000;//r4                 
                    opcode      = 8'b00001001;                     
                    control1    = 5'b00100;//r3             // enable left mux
                    control2    = 0;     
                    imm_control = 1;       //immediate               
                    buff_en     = 1;                    
                end
					 
					 // R5 = r4 - 1 = 6
            s5: begin  
                    immediate   = 16'b0000000000000001; 
                    enable      = 16'b0000000000100000;//r5                 
                    opcode      = 8'b00001001;                     
                    control1    = 5'b00101;//r4            // enable left mux
                    control2    = 0;     
                    imm_control = 1;       //immediate               
                    buff_en     = 1;                    
                end
                            
        endcase
    end
endmodule