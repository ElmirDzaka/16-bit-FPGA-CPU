module decoder(raw_instructions, opcode, rdst, rsrc, immediate, flag_type); // Type flag. 

input      [15:0] raw_instructions;
output reg [7:0] opcode;
output reg [3:0] rdst;
output reg [3:0] rsrc;
output reg [7:0] immediate; //displacemnt


// R-types    4'b0001;
// I-type     4'b0010;
// Load		  4'b0100;
// store		  4'b0101;
// Jumps?     4'b1000;
// Branch     4'b1100;
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
		  
		  //Jump unconditional
		  8'b01001110 : begin
			rdst = 4'bx; // EQ
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1000; // Jump 
		end

		  //JEQ: 01000000
		  8'b01000000 : begin
			rdst = 4'b0000; // EQ
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1000; // Jump 
		end
		
		  // JNE: 01000001
		  8'b01000001 : begin
			rdst = 4'b0001; //NE
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1000; // Jump 
			end
			
		  //JGT: 01000110
		 8'b01000110 : begin
			rdst = 4'b0110; //GT
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1000; // Jump  
			end
			
		  //JLE: 01000111
		   8'b01000111 : begin
			rdst = 4'b0111; //LE
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1000; // Jump
	end		
		 
		 //Branch unconditional
		  8'b11001110 : begin
			rdst = 4'bx; // EQ
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1000; // Jump 
		end
		 
		 //BEQ: 11000000
		 8'b11000000 : begin
			rdst = 4'b0000; //EQ
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1100; // Branch 
			end	
			
		 //BNE: 11000001
		 8'b11000001 : begin
			rdst = 4'b0001; //NE
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1100; // Branch
			end
			
		 //BGT: 11000110
		 8'b11000110 : begin
			rdst = 4'b0110; //GT
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1100; // Branch
			end
			
		 //BLE: 11000111
		 8'b11000111 : begin
			rdst = 4'b0111; //LE
			rsrc = 4'bx;	
			immediate = raw_instructions[7:0];
			flag_type = 4'b1100; // Branch
			end
		  		  
		  
		endcase
		end
		end
endmodule
