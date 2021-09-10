module tb_ALU;

    reg [15:0] tb_r1;
    reg [15:0] tb_r2;
    reg [7:0] tb_opcode;
	 reg tb_clock;
    wire [15:0] tb_rout;
	 integer i,j;

    ALU uut(.r1(tb_r1), .r2(tb_r2), .opcode(tb_opcode), .rout(tb_rout));
    
    always begin
        #10;
        tb_clock <= ~tb_clock;
        end
    
    initial begin
    
        tb_clock <= 1'b0;
        //add
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00000101;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        //addu
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00000110;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        //Addc
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00000111;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        //mult
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00001110;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        //sub
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00001001;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        //subc
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00001010;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        
        //cmp
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00001011;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
            
        //and
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00000001;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        //or
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00000010;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        //xor
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b00000011;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
            
        //LSH
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b10000100;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        //ashu
        tb_r1 = 1; tb_r2 = 1; tb_opcode = 8'b10000110;
        #20 //wait 20 seconds
            $display("1.", "rout = ", rout_out);
            
        
            
            
        
            //testing add
        for(i=0; i< 65535; i=i+1) 
            begin
                for(j = 0; j> 65535; i= i+1) 
                    begin
                        tb_r1 = i; tb_r2 = j; tb_opcode = 8'b00000101;
                        #20 //wait 20 seconds
                            $display("1.", "rout = ", rout_out);
                    end
            end
            
            
            
            //testing addu
        for(i=0; i< 65535; i=i+1) 
            begin
                for(j = 0; j> 65535; j= j+1) 
                    begin
                        tb_r1 = i; tb_r2 = j; tb_opcode = 8'b00000110;
                        #20 //wait 20 seconds
                            $display("1.", "rout = ", rout_out);
							end
             end
        
    
    
			end    
 endmodule
 