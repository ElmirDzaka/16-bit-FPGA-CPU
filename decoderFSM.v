// Decoder Verilog File
// Created By Louis J. Cerda
//
// Module contract decoder:
// in :       Incoming instruction from Ram
// reset:     Reset signal to reset FSM???
// out:        

module decoder(in, out, reset, immediate, enable, opcode, control1, control2, imm_control, buff_en, en_pc, pc_mux_en); //make sure all flags are defined in all cases
	
	// I/0 parameters
	input       [15:0] in;
	output reg [15:0] out;
	reg        [7:0] copcode;  
	reg        [3:0] rdst;
	reg        [3:0] rsrc;
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




// When the program counter advances it stimulates the ram to output the next instuction.
// This always statement should react to incoming next instruction from ram. 
always @(in) begin
	
	// Fetch the first 8 bits 
	copcode <= in [15:8];
	
	
	
	// Checking R-type
   // Register mode (R-Types instructions): compulsory
	
	begin 
		// Fetch Rdest and Rsrc
		rdst = in[7:4];
		rsrc = in[3:0];
	
		case(copcode)
			// add
			8'b00000101 : begin end
			//addu
         8'b00000110 : begin end
			//addc
         8'b00000111 : begin end
			//sub
         8'b00001001 : begin end
			//cmp
         8'b00001011 : begin end
			//AND
         8'b00000001 : begin end
			//Or
         8'b00000010 : begin end
			//xor
         8'b00000011 : begin end
			//lsh
         8'b10000100 : begin end
			//rsh
			8'b00001000 : begin end
			//alsh
         8'b00001100 : begin end
			//arsh
			8'b00001111 : begin end
			//not
			8'b00000100 : begin end
		endcase
	end
end
	
	
	
// These instructions include Aritmetic, logical, Move: are R-type instructions







// Immediate mode (I-Types instructions): compulsory
// These behave similary as R-types instructions

// Direct/Absolute Addressing mode (Dir-type instructions): Not compulsory, can do without


// Indirect Addressing mode (Ind-type instructions): Compulsory


// PC-Relative/Displacement Addressing mode (Rel-type instructions): Compulsory


endmodule 