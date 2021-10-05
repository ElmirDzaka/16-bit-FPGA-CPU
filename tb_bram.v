`timescale 1ps/1ps
module tb_bram;

reg clk, reset;

 wire [47:0] data_a_wire, data_b_wire;
 wire [9:0] addr_a_wire, addr_b_wire;
 wire we_a_wire, we_b_wire;


fsm_bram test1(.data_a(data_a_wire), .data_b(data_b_wire), .addr_a(addr_a_wire), .addr_b(addr_b_wire), .we_a(we_a_wire), .we_b(we_b_wire), .clk(clk), .reset(reset));
bram test2(.data_a(data_a_wire), .data_b(data_b_wire), .addr_a(addr_a_wire), .addr_b(addr_b_wire), .we_a(we_a_wire), .we_b(we_b_wire), .clk(clk));

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
