module ALU(r1, r2, rout, opcode); //make sure all flags are defined in all cases


input [15:0] r1; 
input [15:0] r2;

output reg [15:0] rout;
input [7:0] opcode;
reg [7:0] flag = 8'b00000000; //C == 0, L == 2, F == 5(OF), Z == 6, N == 7

always @(r1, r2, opcode) // maybe remove r1 and r2
	begin 
		case(opcode)
			// add
			8'b00000101 : begin
				flag = 8'b00000000; 
				{flag[0], rout} = r1 + r2;
				
					if(r2[15] == r1[15] && rout[15] != r1[15]) begin
						flag = 8'b00100000;	
					end	
					
					else begin
						flag = 8'b00100000;
					end		
			 end
			 
			//addu
         8'b00000110 : rout = r1 + r2; 
			//addc
         8'b00000111 : rout = r1 + r2 + flag[0]; 
			//sub
         8'b00001001 : begin
				flag = 8'b00000000;
				{flag[0],rout} = r1 + (~r2 + 1); 
				
					if((~r2[15] + 1) == r1[15] && rout[15] != r1[15]) begin
						flag = 8'b00100000;	
					end	
					
					else begin
						flag = 8'b00000000;  
					end
			end
			
			//cmp
         8'b00001011 : begin 
				flag = 8'b00000000;
				rout = r1 - r2;
				
					if(r1 == r2) begin 
						flag = 8'b01000000;
					end
					
					else begin
						flag = 8'b00000000;
							if(($signed(r1) < 0 || $signed(r2) < 0) || ($signed(r1) < 0 && $signed(r2) < 0)) begin			
								if($signed(rout) < $signed(r2)) begin
									flag = 8'b10000000;
								end
								
								else begin
									flag = 8'b00000000;
								end
							end
							
							else begin
								if($signed(rout) < $signed(r2)) begin
									flag = 8'b10000100;
								end
			
								else begin
									flag = 8'b10000000;
								end
							end
					end
			end
			
			
			//AND
         8'b00000001 : rout = r1 & r2; 
			//Or
         8'b00000010 : rout = r1 | r2;
			//xor
         8'b00000011 : rout = r1 ^ r2;
			//lsh
         8'b10000100 : rout = r2 << r1;
			//rsh
			8'b00001000 : rout = r2 >> r1;
			//alsh
         8'b00001100 : rout = r2 <<< r1;
			//arsh
			8'b00001111 : rout = r2 >>> r1;
			//not
			8'b00000100 : rout = ~r1; 
			default: rout = 16'bx;
		endcase
	end
endmodule
