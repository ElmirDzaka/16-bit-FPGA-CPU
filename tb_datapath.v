`timescale 1ps/1ps

module tb_datapath;

reg [15:0] immediate;
reg buff_en;
reg clk;
reg [15:0]enable;
reg reset;
reg [4:0]control1;
reg [4:0]control2;
reg imm_control;
reg [7:0]opcode;

ALUDataPath tes1(.immediate(immediate), .buff_en(buff_en), .clk(clk), .enable(enable), .reset(reset), .control1(control1), .control2(control2), .imm_control(imm_control), .opcode(opcode));

initial begin
 
 clk = 0;
 
 #10
 
 clk = 1;
 
 #10
 
 clk = 0;
 
 #10
 //Reset all enables to 0;
 
 buff_en = 0;
 enable = 16'b0000000000000000;
 reset = 0;
 control1 = 5'b00000;
 control2 = 5'b00000;
 imm_control = 0;
 opcode = 8'b00000000;
 immediate = 16'b0000000000000000;
 
 #10 //load immediate to alu 
 
 buff_en = 0;
 enable = 16'b0000000000000000;
 reset = 0;
 control1 = 5'b00000;
 control2 = 5'b00000;
 imm_control = 1;
 opcode = 0;
 immediate = 16'b0000000000000000;
 
  #10 //load reg0 to alu 
 
 buff_en = 0;
 enable = 16'b0000000000000000;
 reset = 0;
 control1 = 5'b00001;
 control2 = 5'b00000;
 imm_control = 0;
 opcode = 0;
 immediate = 16'b0000000000000000;
 
 
 #10 //give alu opcode and output computation 
 
 buff_en = 1;
 enable = 16'b0000000000000001;
 reset = 0;
 control1 = 5'b00000;
 control2 = 5'b00000;
 imm_control = 0;
 opcode = 8'b00000001;
 immediate = 16'b0000000000000000;
 
end
always #10 clk = ~clk;
 


endmodule
