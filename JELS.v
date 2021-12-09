// Testbench for r-type instructions 
`timescale 1ps/1ps
module JELS;

reg clk, reset, up, down, left, right;

 
	ALUDataPath uut (.clk(clk),  .reset(reset), .left(left), .right(right), .down(down), .up(up));
						
 

initial begin
 clk = 0;
 reset = 1;
 
 #20
 
 reset = 0;   // Is when registers are reset
 
 #20
 
 reset = 1;   // When the FSM starts
 
  #20
 
 reset = 1;   // When the FSM starts
 
  
  #4010
 
 right = 1;   // When the FSM starts
 
 #1000
 
 right = 0;   // When the FSM starts
 
 #2000
 
 up = 1;   // When the FSM starts
 
 #1000
 
 up = 0;   // When the FSM starts
 
 #2000
 
 down = 1;   // When the FSM starts
 
 #1000
 
 down = 0;   // When the FSM starts
 

end
always #20 clk = ~clk;



endmodule

