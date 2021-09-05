module ALU(r1, r2, rout, opcode);

input [15:0] r1;
input [15:0] r2;
input [15:0] rout;
input [7:0] opcode;

always @(r1, r2, opcode)
	begin 
		case(opcode)
			8'b00000101 = //add
			8'b00000110 = //addu
			8'b00000111 = //addc
			8'b00001110 = //mult
			8'b00001001 = //sub
			8'b00001010 = //subc
			8'b00001011 = //cmp
			8'b00000001 = //AND
			8'b00000010 = //OR
			8'b00000011 = //XOR
			8'b10000100 = //LSH
			8'b10000110 = //ashu
			8'b00000000 = //Weight
		endcase
	end
endmodule
