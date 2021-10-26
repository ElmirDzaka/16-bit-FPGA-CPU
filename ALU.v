module ALU(r1, r2, rout, opcode, flags_in, flags_out); //make sure all flags are defined in all cases


input [15:0] r1; 
input [15:0] r2;
//TODO: modify code when flags are used (addc) 
input [7:0] flags_in;

output reg [15:0] rout;
input [7:0] opcode;
//reg [7:0] flags = 8'b00000000; //C == 0, L == 2, F == 5(OF), Z == 6, N == 7

output reg [7:0] flags_out;

always @(r1, r2, opcode) // maybe remove r1 and r2
    begin 
        case(opcode)
            // add
            8'b00000101 : begin
                flags_out = 8'b00000000; 
                {flags_out[0], rout} = r1 + r2;
                
                    if(r2[15] == r1[15] && rout[15] != r1[15]) begin
                        flags_out = 8'b00100000;    
                    end    
                    
                    else begin
                        flags_out = 8'b00000000;
                    end        
             end
             
            //addu
         8'b00000110 : begin 
                    rout = r1 + r2; 
                    flags_out =  8'b00000000;
            end
            //addc
         8'b00000111 : begin
                rout = r1 + r2 + flags_in[0];
                flags_out =  8'b00000000;
        end    
            //sub
         8'b00001001 : begin
                flags_out = 8'b00000000;
                {flags_out[0],rout} = r1 + (~r2 + 1); 
                
                    if((~r2[15] + 1) == r1[15] && rout[15] != r1[15]) begin
                        flags_out = 8'b00100000;    
                    end    
                    
                    else begin
                        flags_out = 8'b00000000;  
                    end
            end
            
            //cmp
         8'b00001011 : begin 
                flags_out = 8'b00000000;
                rout = r1 - r2;
                
                    if(r1 == r2) begin 
                        flags_out = 8'b01000000;
                    end
                    
                    else begin
                        flags_out = 8'b00000000;
                            if(($signed(r1) < 0 || $signed(r2) < 0) || ($signed(r1) < 0 && $signed(r2) < 0)) begin            
                                if($signed(rout) < $signed(r2)) begin
                                    flags_out = 8'b10000000;
                                end
                                
                                else begin
                                    flags_out = 8'b00000000;
                                end
                            end
                            
                            else begin
                                if($signed(rout) < $signed(r2)) begin
                                    flags_out = 8'b10000100;
                                end
            
                                else begin
                                    flags_out = 8'b10000000;
                                end
                            end
                    end
            end
            
            
            //AND
         8'b00000001 : begin
            rout = r1 & r2; 
            flags_out =  8'b00000000;
            end
            //Or
         8'b00000010 : begin
            rout = r1 | r2;
            flags_out =  8'b00000000;
            end
            //xor
         8'b00000011 : begin 
            rout = r1 ^ r2;
            flags_out =  8'b00000000;
            end
            //lsh
         8'b10000100 : begin
            rout = r2 << r1;
            flags_out =  8'b00000000;
            end
            //rsh
            8'b00001000 : begin
            rout = r2 >> r1;
            flags_out =  8'b00000000;
            end
            //alsh
         8'b00001100 :begin
            rout = r2 <<< r1;
            flags_out =  8'b00000000;
            end
            //arsh
            8'b00001111 : begin
            rout = r2 >>> r1;
            flags_out =  8'b00000000;
            end
            //not
            8'b00000100 : begin
            rout = ~r1; 
            flags_out =  8'b00000000;
            end
            default: begin rout = 16'bx;
            flags_out =  8'b00000000;
            end
        endcase
    end
endmodule