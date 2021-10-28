module decoder(raw_instructions, opcode, rdst, rsrc, immediate, flag_type); // Type flag. 

input      [15:0] raw_instructions;
output reg [7:0] opcode;
output reg [3:0] rdst;
output reg [3:0] rsrc;
output reg [7:0] immediate;


// R-types    4'b0001;
// I-type     4'b0010;
// Load/Store 4'b0100;
// Jumps?     4'b1000;

output reg [3:0] flag_type; 




always @(raw_instructions) begin

	opcode = raw_instructions [15:8];
	case(opcode) 
	
		// add
		8'b00000101 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//addu
		8'b00000110 : begin
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
		   flag_type = 4'b0001; // R-type 
		end
		
		//addc
		8'b00000111 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//sub
		8'b00001001 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//cmp
		8'b00001011 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//AND
		8'b00000001 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//Or
		8'b00000010 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//xor
		8'b00000011 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 

		end
		
		//lsh
		8'b10000100 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//rsh
		8'b00001000 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//alsh
		8'b00001100 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//arsh
		8'b00001111 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end
		
		//not
		8'b00000100 : begin 
			rdst = raw_instructions[7:4];
			rsrc = raw_instructions[3:0];	
			immediate = 8'bx;
			flag_type = 4'b0001; // R-type 
		end		
	
	
	
	endcase
end

endmodule
