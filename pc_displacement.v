module pc_displacement(pc_in, imm_in, flags,flag_type, dis_out, condition);

    input [15:0] pc_in;
    input [15:0]  imm_in;
	 input [7:0]  flags;
	 input [3:0]  flag_type;
	 input [3:0]  condition;

    output reg [15:0] dis_out;
	 

		always@(imm_in, pc_in) begin
			//checks if jump
			if(flag_type == 4'b1000) begin
				case(condition) 
					//EQ
					4'b0000: begin
								if(flags[6] == 1) begin
									dis_out = imm_in;
								end
								else begin
									dis_out = pc_in + 1;
								end
								end
					//NE			
					4'b0001: begin
								if(flags[6] == 0) begin
									dis_out = imm_in;
								end
								else begin
									dis_out = pc_in + 1;
								end
					
								end
					//GT		
					4'b0110: begin
								if((flags[6] == 1) || (flags[7] == 1)) begin
									dis_out = imm_in;
								end
								else begin
									dis_out = pc_in + 1;
								end
								end
					//LE	
					4'b0111: begin
								if(flags[7] == 0) begin
									dis_out = imm_in;
								end
								else begin
									dis_out = pc_in + 1;
								end
								end
								
								//Unconditional
                    4'b1110: begin
                                    dis_out = imm_in;
                                end
								
				
				endcase
			end
			
			//if branch
			if(flag_type == 4'b1100) begin
				case(condition)
							//EQ
					4'b0000: begin
								if(flags[6] == 1) begin
									dis_out = pc_in + imm_in;
								end
								else begin
									dis_out = pc_in + 1;
								end
								end
					//NE			
					4'b0001: begin
								if(flags[6] == 0) begin
									dis_out = pc_in + imm_in;
								end
								else begin
									dis_out = pc_in + 1;
								end
					
								end
					//GT		
					4'b0110: begin
								if(flags[7] == 1) begin
									dis_out = pc_in + imm_in;
								end
								else begin
									dis_out = pc_in + 1;
								end
								end
					//LE	
					4'b0111: begin
								if(flags[7] == 0) begin
									dis_out = pc_in + imm_in;
								end
								else begin
									dis_out = pc_in + 1;
								end
								end
								
								//Unconditional
                    4'b1110: begin
                                    dis_out = imm_in;
                                end
								
				endcase
			end
			end		
		
  endmodule
	 