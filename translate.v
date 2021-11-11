module translate (rsrc_in, rdst_in, rsrc_out, rdst_out, rdst_out_write, imm_in, imm_out);

	input [3:0] rsrc_in; // src
	input [3:0] rdst_in; // dest
	input [7:0] imm_in;  // incoming immediate
	
	output reg[4:0]  rsrc_out; // src 
	output reg[4:0] rdst_out; // dst
	output reg[15:0] rdst_out_write; // src
	output reg[15:0] imm_out; // outcoming immediate
	
	
   // Converts rsrc_in from 4'bits to 16'bits rsrc_out
	// And, converts rsrc_in from 4'bits to 5'bits
	always@(rdst_in) begin
	
		case(rdst_in)
		4'b0000: begin rdst_out = 5'b00001; //r0
					rdst_out_write = 16'b0000000000000001; //r0
					end
					
		4'b0001: begin rdst_out = 5'b00010; //r1
					rdst_out_write = 16'b0000000000000010; //r1
					end
					
		4'b0010: begin rdst_out = 5'b00011; //r2
		         rdst_out_write = 16'b0000000000000100; //r2
					end
					
		4'b0011: begin rdst_out = 5'b00100; //r3
		         rdst_out_write = 16'b0000000000001000; //r3
					end
					
		4'b0100: begin rdst_out = 5'b00101; //r4
		         rdst_out_write = 16'b0000000000010000; //r4
					end
					
		4'b0101: begin rdst_out = 5'b00110; //r5
		         rdst_out_write = 16'b0000000000100000; //r5
					end
					
		4'b0110: begin rdst_out = 5'b00111; //r6
		         rdst_out_write = 16'b0000000001000000; //r6
					end
					
		4'b0111: begin rdst_out = 5'b01000; //r7
		         rdst_out_write = 16'b0000000010000000; //r7
					end
					
		4'b1000: begin rdst_out = 5'b01001; //r8
		         rdst_out_write = 16'b0000000100000000; //r8
					end
					
		4'b1001: begin rdst_out = 5'b01010; //r9
		         rdst_out_write = 16'b0000001000000000; //r9
					end
					
		4'b1010: begin rdst_out = 5'b01011; //r10
		         rdst_out_write = 16'b0000010000000000; //r10
					end
					
		4'b1011: begin rdst_out = 5'b01100; //r11
		         rdst_out_write = 16'b0000100000000000; //r11
					end
					
		4'b1100: begin rdst_out = 5'b01101; //r12
		         rdst_out_write = 16'b0001000000000000; //r12
					end
					
		4'b1101: begin rdst_out = 5'b01110; //r13
		         rdst_out_write = 16'b0010000000000000; //r13
					end
					
		4'b1110: begin rdst_out = 5'b01111; //r14
		         rdst_out_write = 16'b0100000000000000; //r14
					end
					
		4'b1111: begin rdst_out = 5'b10000; //r15
				   rdst_out_write  = 16'b1000000000000000; //r15
					end
			
		endcase
	end
	
	// Converts rdst_in from 4'bits to 16'bits rdst_out
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
	
	
	// Translates the immediate values
	always@(imm_in) begin
         if(imm_in[7] == 1) begin
            imm_out = {8'b11111111,imm_in};
         end
         else begin
                imm_out = {8'b00000000, imm_in};
         end

    end
	
endmodule
	
	