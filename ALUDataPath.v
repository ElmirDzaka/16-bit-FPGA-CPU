module ALUDataPath(clk, reset);

input clk;
input reset;
wire [15:0] enable; //15'b0000000000011
wire [4:0] control1;
wire [4:0] control2;
wire imm_control;
wire[7:0] opcode;
wire [15:0] immediate;
wire buff_en;
wire [15:0] out;

wire [15:0] mux1_wire;
wire [15:0] mux2_wire;
wire [15:0] mux3_wire;
wire [15:0] alu_out; // This is not used
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

wire[7:0] read_flags;
wire[7:0] write_flags;

wire flag_en;

//pc_mux wires
wire [15:0] pc_mux_immediate;
wire pc_mux_en;
wire [15:0] pc_mux_data_in;
wire [15:0] pc_mux_out;

//bram wires
 wire [47:0] data_a_wire, data_b_wire;
 wire [9:0] addr_a_wire, addr_b_wire;
 wire we_a_wire, we_b_wire;
 wire [47:0] q_a_wire, q_b_wire;
 
//program counter wires
wire en_pc_wire;
//wire [15:0] pc_result;

//decoder fsm wires




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

//regflag // edit output to fsm
regflag flags(.D_in(write_flags), .wEnable(flag_en), .reset(reset), .clk(clk), .r(read_flags));

//ALU
ALU alu(.r1(mux1_wire), .r2(mux3_wire), .rout(out), .opcode(opcode), .flags_in(read_flags), .flags_out(write_flags));

//tristatebuffer
tristatebuffer tristatebuffer1(.inp(out), .en(buff_en), .out(buff_out));


//pc mux
pc_mux mux_pc(.immediate(pc_mux_immediate), .pc_mux_en(pc_mux_en), .data_in(pc_mux_data_in), .out(pc_mux_out));

//program counter
program_counter pc(.in_pc(pc_mux_out), .en_pc(en_pc_wire), .pc_result(addr_a_wire), .reset(reset));

//bram
bram ram(.data_a(data_a_wire), .data_b(data_b_wire), .addr_a(addr_a_wire), .addr_b(addr_b_wire), .we_a(we_a_wire), .we_b(we_b_wire), .clk(clk), .q_a(q_a_wire), .q_b(q_b_wire));


//decoder


//global_fsm


//translator

//IR

endmodule