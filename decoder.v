module decoder(raw_instructions, opcode, rdst, rsrc, immediate, flag_type); // Type flag. 

input      [15:0] raw_instructions;
output reg [7:0] opcode;
output reg [3:0] rdst;
output reg [3:0] rsrc;
output reg [7:0] immediate;


// R-types    4'b0001;
// I-type     4'b0010;
// Load		  4'b0100;
// store		  4'b0101;
// Jumps?     4'b1000;
// Wait       4'b0000;

output reg [3:0] flag_type; 

parameter [3:0] addi  = 4'b0101;
parameter [3:0] subi  = 4'b1001;


always @(raw_instructions) begin
	
   if(raw_instructions[15:12] == addi) begin
		opcode    = raw_instructions[15:12];
      rdst      = raw_instructions[11:8];
      immediate = raw_instructions[7:0];
      flag_type = 4'b0010;
	end

	else begin
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
	
		//addi
		8'b01001111 : begin
			rdst = raw_instructions[3:0];
			rsrc = 4'bx;	
			immediate = raw_instructions[7:4];
			flag_type = 4'b0010; // I-type 
		end
		
		//store
        8'b10000111 : begin 
            rdst = raw_instructions[7:4];
            rsrc = raw_instructions[3:0];
            immediate = 8'bx;
            flag_type = 4'b0101; // store-type 
        end

        //load
        8'b10000101 : begin 
            rdst = raw_instructions[7:4];
            rsrc = raw_instructions[3:0];
            immediate = 8'bx;
            flag_type = 4'b0100; // load-type 
        end
		  
		  //wait (do nothing)
        8'b00000000 : begin 
            rdst = raw_instructions[7:4];
            rsrc = raw_instructions[3:0];
            immediate = 8'bx;
            flag_type = 4'b0000; // load-type 
        end
		  
		  
		  
		  
		  
		endcase
		end
		end
endmodule
