module fsm_sum(clk, reset, immediate, buff_en, enable, control1, control2, imm_control, opcode);
input clk, reset;

output reg [15:0] immediate;
reg[3:0] y;
output reg buff_en;
output reg [15:0]enable;
output reg [4:0]control1;
output reg [4:0]control2;
output reg imm_control;
output reg [7:0]opcode;

parameter [3:0]s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011, s4 = 4'b0100, 
					s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111, s8 = 4'b1000, s9 = 4'b1001;
					
always@(posedge clk, negedge reset)
	if(reset == 0) y <= s0; //reset values
	else
		case(y)
			s0: y <= s1; //load 0 into immediate
			s1: y <= s2; //take value from reg0
			s2: y <= s3; //and both values and return 0 to reg0
			s3: y <= s4; //load 1 into immediate
			s4: y <= s5; //take value from reg0
			s5: y <= s6; //add both values and return value to reg0
			s6: y <= s7; //load 2 into immediate
			s7: y <= s8; //take value from reg0
			s8: y <= s9; //add both values
			default: y <= s0; //hold value
		endcase
		
always@(y)
	case(y)
	s0: begin //reset 
			immediate = 16'b0000000000000000; 
			buff_en = 0; 
			enable = 16'b0000000000000000; 
			control1 = 5'b00000; 
			control2 = 5'b00000; 
			imm_control = 0; 
			opcode =  8'b00000000; 
		 end 
	s1: begin //take value from reg0
			immediate = 16'b0000000000000000; 
			buff_en = 0; 
			enable = 16'b0000000000000001; 
			control1 = 5'b00001; 
			control2 = 5'b00000; 
			imm_control = 0; 
			opcode =  8'b00000000; 
	    end
	s2: begin ////load 0 into immediate
			immediate = 16'b0000000000000000; 
			buff_en = 0; 
			enable = 16'b0000000000000000; 
			control1 = 5'b00000; 
			control2 = 5'b00000; 
			imm_control = 1; 
			opcode =  8'b00000000; 
		 end
	s3: begin //and both values enable buff and store in reg
			immediate = 16'b0000000000000000; 
			buff_en = 1; 
			enable = 16'b0000000000000001; 
			control1 = 5'b00000; 
			control2 = 5'b00000; 
			imm_control = 1; 
			opcode = 8'b000000001; //!
		 end
	s4: begin //take value from reg0
			immediate = 16'b0000000000000000; 
			buff_en = 0; 
			enable = 16'b0000000000000001; 
			control1 = 5'b00001; 
			control2 = 5'b00000; 
			imm_control = 0; 
			opcode =  8'b00000000; 
		 end
	s5: begin //load 1 into immedaite
			immediate = 16'b0000000000000001; 
			buff_en = 0; 
			enable = 16'b0000000000000000; 
			control1 = 5'b00000; 
			control2 = 5'b00000; 
			imm_control = 1; 
			opcode =  8'b00000000; 
		 end

	s6: begin //add both values and return value to reg0
			immediate = 16'b0000000000000000; 
			buff_en = 1; 
			enable = 16'b0000000000000001; 
			control1 = 5'b00000; 
			control2 = 5'b00000; 
			imm_control = 1; 
			opcode =  8'b000000101; //!
	    end

	s7: begin //take value from reg0
			immediate = 16'b0000000000000000; 
			buff_en = 0; 
			enable = 16'b0000000000000001; 
			control1 = 5'b00001; 
			control2 = 5'b00000; 
			imm_control = 0; 
			opcode =  8'b00000000;  
		 end
	s8: begin //load 2 into immediate
			immediate = 16'b0000000000000010; 
			buff_en = 0; 
			enable = 16'b0000000000000000; 
			control1 = 5'b00000; 
			control2 = 5'b00000; 
			imm_control = 1; 
			opcode =  8'b00000000; 
	    end
	s9: begin 
			immediate = 16'b0000000000000000; 
			buff_en = 1; 
			enable = 16'b0000000000000001; 
			control1 = 5'b00000; 
			control2 = 5'b00000; 
			imm_control = 1; 
			opcode =  8'b000000101; //!
		  end
			default: begin
					immediate = 16'b0000000000000000; 
					buff_en = 0; 
					enable = 16'b0000000000000000; 
					control1 = 5'b00000; 
					control2 = 5'b00000; 
					imm_control = 0; 
					opcode =  8'b00000000; 
			          end
	endcase
endmodule
