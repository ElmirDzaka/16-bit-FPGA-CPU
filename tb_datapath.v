`timescale 1ps/1ps

module tb_datapath;

wire [15:0] immediate_test;
wire buff_en_test;
reg clk;
wire [15:0]enable_test;
reg reset;
wire [4:0]control1_test;
wire [4:0]control2_test;
wire imm_control_test;
wire [7:0]opcode_test;

fsm_sum tes2(.clk(clk), .reset(reset), .immediate(immediate_test), .buff_en(buff_en_test), .enable(enable_test), .control1(control1_test), .control2(control2_test), .imm_control(imm_control_test), .opcode(opcode_test));
ALUDataPath tes1(.immediate(immediate_test), .buff_en(buff_en_test), .clk(clk), .enable(enable_test), .reset(reset), .control1(control1_test), .control2(control2_test), .imm_control(imm_control_test), .opcode(opcode_test));


// EDIT changed rest from 1,0,1 -> 0,1,0
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
