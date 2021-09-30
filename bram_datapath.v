module bram_datapath(clk, reset, z);

input clk;
input reset;

output reg [6:0]z;

 wire [47:0] data_a_wire, data_b_wire;
 wire [9:0] addr_a_wire, addr_b_wire;
 wire we_a_wire, we_b_wire;


fsm_bram test1(.data_a(data_a_wire), .data_b(data_b_wire), .addr_a(addr_a_wire), .addr_b(addr_b_wire), .we_a(we_a_wire), .we_b(we_a_wire), .clk(clk));
bram test2(.data_a(data_a_wire), .data_b(data_b_wire), .addr_a(addr_a_wire), .addr_b(addr_b_wire), .we_a(we_a_wire), .we_b(we_a_wire), .clk(clk));


endmodule
