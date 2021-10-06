// Module for the Fibonacci sequence
// Created by Louis J. Cerda on 9/23/2021
// Fibonacci sequnce for reference
// 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144

// ns Logic: Next state transitions

module fsm_bram (data_a, data_b, addr_a, addr_b, we_a, we_b, clk,reset);
		
	input clk;
	input reset;
   output reg [47:0] data_a, data_b;
	output reg [9:0] addr_a, addr_b;
	output reg we_a, we_b;

    
   // ps -> Previous state, ns -> Next state
   reg [3:0] ps, ns; 
    
   //Need to add more state parameters as needed
   parameter [3:0] s0  = 4'b0000;
   parameter [3:0] s1  = 4'b0001;
   parameter [3:0] s2  = 4'b0010;
   parameter [3:0] s3  = 4'b0011;
   parameter [3:0] s4  = 4'b0100;
	parameter [3:0] s5  = 4'b0101;

       
    //Sequential block, negedge of reset due to push button
    always @ (negedge clk) begin

        ps <= ns;

    end
    
    // Combinational block, responsible fo setting the next state
    always@(posedge clk, negedge reset) begin
		if(reset == 0) begin    
			ns = s0;
		end
		 
		 
		else begin
			// Need to add more stepping
        case(ps)
           s0: ns <= s1;  // EDIT changed s1: ns <= si  to s0: ns <= si
			  s1: ns <= s2;
			  s2: ns <= s3;
			  s3: ns <= s4;
			  s4: ns <= s5;
			  s5: ns <= s5;

           default: ns <= s0;
        endcase
		end
    end


    always@ (ps) begin

        case(ps)
            //read value at address 1 using port a
            s0: begin   
                    data_a   = 0; //Data to A             [47:0]
                    data_b   = 0;  //Data to B             [47:0]
                    addr_a   = 1;  //Memory Address from A [9: 0]
                    addr_b   = 0;  //Memory Addres from B  [9: 0]
                    we_a     = 0;  //Write enable A        [1bit]
                    we_b     = 0;  //Write enable B        [1bit]
                end
                
            // write value 10 to address 1 using port a
            s1: begin  
                    data_a   = 10; //Data to A             [47:0]
                    data_b   = 0;  //Data to B             [47:0]
                    addr_a   = 1;  //Memory Address from A [9: 0]
                    addr_b   = 0;  //Memory Addres from B  [9: 0]
                    we_a     = 1;  //Write enable A        [1bit]
                    we_b     = 0;  //Write enable B        [1bit]
                end
					 
				 // reading value at address 1
            s2: begin  
                    data_a   = 0; //Data to A             [47:0]
                    data_b   = 0;  //Data to B             [47:0]
                    addr_a   = 1;  //Memory Address from A [9: 0]
                    addr_b   = 0;  //Memory Addres from B  [9: 0]
                    we_a     = 0;  //Write enable A        [1bit]
                    we_b     = 0;  //Write enable B        [1bit]
                end
					 
					 
				 //reading value at address 2 
            s3: begin  
                    data_a   = 0; //Data to A             [47:0]
                    data_b   = 0;  //Data to B             [47:0]
                    addr_a   = 0;  //Memory Address from A [9: 0]
                    addr_b   = 2;  //Memory Addres from B  [9: 0]
                    we_a     = 0;  //Write enable A        [1bit]
                    we_b     = 0;  //Write enable B        [1bit]
                end
					 
				// writing value 20 to address 2
				s4: begin  
                    data_a   = 0; //Data to A             [47:0]
                    data_b   = 20;  //Data to B             [47:0]
                    addr_a   = 0;  //Memory Address from A [9: 0]
                    addr_b   = 2;  //Memory Addres from B  [9: 0]
                    we_a     = 0;  //Write enable A        [1bit]
                    we_b     = 1;  //Write enable B        [1bit]
                end
				
				// reading value at address 2
				s5: begin  
                    data_a   = 0; //Data to A             [47:0]
                    data_b   = 0;  //Data to B             [47:0]
                    addr_a   = 0;  //Memory Address from A [9: 0]
                    addr_b   = 2;  //Memory Addres from B  [9: 0]
                    we_a     = 0;  //Write enable A        [1bit]
                    we_b     = 0;  //Write enable B        [1bit]
                end
                            
        endcase
    end
endmodule