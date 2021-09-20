module ALUDataPath(data, clk, enable, reset);

input clk;
input reset
input [15:0] data;
input [15:0] enable;
input control1;
input control2;
wire [15:0] bus1;
wire [15:0] bus2;
wire [15:0] mux1_wire;
wire [15:0] mux2_wire;
wire [15:0] alu_out;


RegBank RegBank0(.ALUBus(alu_out), r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, .regEnable(enable), .clk(clk), .reset(reset));

mux mux1(.bus(bus1), .control(control1), .out(mux1_wire));
mux mux2(.bus(bus2), .control(control2), .out(mux2_wire));

ALU alu(.r1(mux1_wire), .r2(mux2_wire), .rout(alu_out), opcode);

endmodule
