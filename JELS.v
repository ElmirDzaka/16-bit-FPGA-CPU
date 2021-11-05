// Testbench for r-type instructions
`timescale 1ps/1ps
module JELS;

reg clk, reset;

 wire [47:0] data_a_wire, data_b_wire;
 wire [9:0] addr_a_wire, addr_b_wire;
 wire we_a_wire, we_b_wire;
 

 
 
	ALUDataPath uut (.clk(clk),  .reset(reset));
						
 

initial begin
 clk = 0;
 reset = 1;
 
 #20
 
 reset = 0;   // Is when registers are reset
 
 #20
 
 reset = 1;   // When the FSM starts

end
always #20 clk = ~clk;



endmodule

