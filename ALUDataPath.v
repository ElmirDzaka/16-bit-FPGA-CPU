module ALUDataPath(immediate, buff_en, clk, enable, reset, control1, control2, imm_control, opcode, out);

input clk;
input reset;
input [15:0] enable; //15'b0000000000011
input [4:0] control1;
input [4:0] control2;
input imm_control;
input[7:0] opcode;
input [15:0] immediate;
input buff_en;
output out;

wire [15:0] mux1_wire;
wire [15:0] mux2_wire;
wire [15:0] mux3_wire;
wire [15:0] alu_out;
wire [15:0] buff_out;

wire [15:0] r0_wire;
wire [15:0] r1_wire;
wire [15:0] r2_wire;
wire [15:0] r3_wire;
wire [15:0] r4_wire;
wire [15:0] r5_wire;
wire [15:0] r6_wire;
wire [15:0] r7_wire;
wire [15:0] r8_wire;
wire [15:0] r9_wire;
wire [15:0] r10_wire;
wire [15:0] r11_wire;
wire [15:0] r12_wire;
wire [15:0] r13_wire;
wire [15:0] r14_wire;
wire [15:0] r15_wire;



//regbank
RegBank RegBank0(.ALUBus(buff_out), .r0(r0_wire), .r1(r1_wire), .r2(r2_wire), .r3(r3_wire), .r4(r4_wire), .r5(r5_wire), .r6(r6_wire), .r7(r7_wire), .r8(r8_wire), .r9(r9_wire), .r10(r10_wire), .r11(r11_wire), .r12(r12_wire), .r13(r13_wire), .r14(r14_wire), .r15(r15_wire), .regEnable(enable), .clk(clk), .reset(reset));

//mux1
mux mux1(.control(control1), .out(mux1_wire), .r0(r0_wire), .r1(r1_wire), .r2(r2_wire), .r3(r3_wire), .r4(r4_wire), .r5(r5_wire), .r6(r6_wire), .r7(r7_wire), .r8(r8_wire), .r9(r9_wire), .r10(r10_wire)
, .r11(r11_wire), .r12(r12_wire), .r13(r13_wire), .r14(r14_wire), .r15(r15_wire));

//mux2
mux mux2(.control(control2), .out(mux2_wire), .r0(r0_wire), .r1(r1_wire), .r2(r2_wire), .r3(r3_wire), .r4(r4_wire), .r5(r5_wire), .r6(r6_wire), .r7(r7_wire), .r8(r8_wire), .r9(r9_wire), .r10(r10_wire)
, .r11(r11_wire), .r12(r12_wire), .r13(r13_wire), .r14(r14_wire), .r15(r15_wire));

//immediate mux
imm_mux mux3(.immediate(immediate),.control(imm_control), .data_in(mux2_wire), .out(mux3_wire));

//ALU
ALU alu(.r1(mux1_wire), .r2(mux3_wire), .rout(out), .opcode(opcode));

//tristatebuffer
tristatebuffer tristatebuffer1(.inp(out), .en(buff_en), .out(buff_out));

endmodule
