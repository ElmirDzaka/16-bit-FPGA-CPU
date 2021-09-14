module ALU(r1, r2, rout, opcode);

input [15:0] r1;
input [15:0] r2;
output reg [15:0] rout;
input [7:0] opcode;
reg [7:0] flag = 7'b0000000; //C == 0, L == 2, F == 5(OF), Z == 6, N == 7


always @(r1, r2, opcode)
	begin 
		case(opcode)
			8'b00000101 : begin
				{flag[0], rout} = r1 + r2;
				//rout = r1 + r2;//add
				if(r2[15] == r1[15] && rout[15] != r1[15]) begin
					flag[5] = 1;	
				end	
					else begin
						flag[5] = 0;
					end
			
			 end 
         8'b00000110 : rout = r1 + r2; //addu
         8'b00000111 : rout = r1 + r2 + flag[0]; //addc
        // 8'b00001110 : rout = r1 * r2;//mult
         8'b00001001 : begin
				{flag[0],rout} = r1 + (~r2 + 1); //sub
				
				if((~r2[15] + 1) == r1[15] && rout[15] != r1[15]) begin
					flag[5] = 1;	
				end	
					else begin
						flag[5] = 0;
					end
			end
         //8'b00001010 : rout = r1 - r2; //subc
			
         8'b00001011 : begin //cmp
//				rout = r1 - r2;
//				if(rout == 0 ) begin
//					flag[6] = 1;
//				end 
//				else begin
//					flag[6] = 0;
//				end
//			//	if(r1 > 0 && r2 > 0) begin
//				if(rout < r1) begin 
//					flag[2] = 1;
//					end
//				else begin
//					flag[2] = 0; //comment
//					end
//		//		end
//			//	else if ($signed(r1) && $signed(r2))begin
//				if($signed(rout) < $signed(r1)) begin
//					flag[7] = 1;
//				end 
//				else begin
//					flag[7] = 0;
//					end
//			//	end
				rout = r1 - r2;
				
				if(r1 == r2) begin 
						flag[6] = 1;
				end
		   	else begin
					flag[6] = 0;
					if(($signed(r1) < 0 || $signed(r2) < 0) || ($signed(r1) < 0 && $signed(r2) < 0)) begin			
						if($signed(rout) < $signed(r2)) begin
							flag[7] = 1;
						end
						else begin
							flag[7] = 0;
						end
					end
					else begin
						if($signed(rout) < $signed(r2)) begin
							flag[2] = 1;
						end
						else begin
							flag[2] = 0;
						end
					end
				end
			end
         8'b00000001 : rout = r1 & r2; //AND
         8'b00000010 : rout = r1 | r2; //Or
         8'b00000011 : rout = r1 ^ r2; // xor
         8'b10000100 : rout = r2 << r1; //lsh
			8'b00001000 : rout = r2 >> r1;//rsh
         8'b00001100 : rout = r2 <<< r1;//alsh
			8'b00001111 : rout = r2 >>> r1;//arsh
			8'b00000100 : rout = ~r1; //not
		endcase
	end
endmodule
