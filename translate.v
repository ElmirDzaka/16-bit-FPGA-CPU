module translate (rsrc_in, rdst_in, rsrc_out, rdst_out);

	input [3:0] rsrc_in;
	input [3:0] rdst_in;
	
	output reg[4:0]  rsrc_out;
	output reg[15:0] rdst_out;
	
	
	always@(rsrc_in) begin
	
		case(rsrc_in)
		4'b0000: rsrc_out = 5'b00001; //r0
		4'b0001: rsrc_out = 5'b00010; //r1
		4'b0010: rsrc_out = 5'b00011; //r2
		4'b0011: rsrc_out = 5'b00100; //r3
		4'b0100: rsrc_out = 5'b00101; //r4
		4'b0101: rsrc_out = 5'b00110; //r5
		4'b0110: rsrc_out = 5'b00111; //r6
		4'b0111: rsrc_out = 5'b01000; //r7
		4'b1000: rsrc_out = 5'b01001; //r8
		4'b1001: rsrc_out = 5'b01010; //r9
		4'b1010: rsrc_out = 5'b01011; //r10
		4'b1011: rsrc_out = 5'b01100; //r11
		4'b1100: rsrc_out = 5'b01101; //r12
		4'b1101: rsrc_out = 5'b01110; //r13
		4'b1110: rsrc_out = 5'b01111; //r14
		4'b1111: rsrc_out = 5'b10000; //r15
		endcase
	end
	
	
	always@(rdst_in) begin
		
		case(rdst_in)
		4'b0000: rdst_out = 16'b0000000000000001; //r0
		4'b0001: rdst_out = 16'b0000000000000010; //r1
		4'b0010: rdst_out = 16'b0000000000000100; //r2
		4'b0011: rdst_out = 16'b0000000000001000; //r3
		4'b0100: rdst_out = 16'b0000000000010000; //r4
		4'b0101: rdst_out = 16'b0000000000100000; //r5
		4'b0110: rdst_out = 16'b0000000001000000; //r6
		4'b0111: rdst_out = 16'b0000000010000000; //r7
		4'b1000: rdst_out = 16'b0000000100000000; //r8
		4'b1001: rdst_out = 16'b0000001000000000; //r9
		4'b1010: rdst_out = 16'b0000010000000000; //r10
		4'b1011: rdst_out = 16'b0000100000000000; //r11
		4'b1100: rdst_out = 16'b0001000000000000; //r12
		4'b1101: rdst_out = 16'b0010000000000000; //r13
		4'b1110: rdst_out = 16'b0100000000000000; //r14
		4'b1111: rdst_out = 16'b1000000000000000; //r15
		endcase
	end
endmodule
	
	