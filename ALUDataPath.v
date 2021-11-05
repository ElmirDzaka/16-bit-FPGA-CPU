module ALUDataPath(clk, reset);

input clk;
input reset;
wire [15:0] enable; //15'b0000000000011
wire [4:0] control1;
wire [4:0] control2;
wire imm_control;
wire[7:0] opcode;
wire [15:0] immediate;
wire [7:0] ram_immediate;

wire buff_en;
wire [15:0] out;

wire [15:0] mux1_wire;
wire [15:0] mux2_wire;
wire [15:0] mux3_wire;
wire [15:0] alu_out; // This is not used
wire [15:0] buff_out;

// Wires we added
wire [3:0] rdst;
wire [3:0] rsrc;
wire [3:0] flag_type;
wire [4:0] rsrc_translated;
wire [15:0] rdst_translated;
wire IR_enable;
wire [15:0] IR_out; // Wire size will have to change.
wire we_enable;
wire [7:0] fsm_immediate;
wire [15:0] fsm_rdst_out;
wire [4:0] fsm_rsrc_out;
//wire [7:0] fsm_flags;
wire fsm_pc_en;
wire fsm_flag_enable;
wire [7:0] fsm_opcode_out;
wire ls_control;
wire [15:0] ls_out;
wire [15:0] rdst_out_write_wire;



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
 wire [15:0] data_a_wire, data_b_wire;
 wire [9:0] addr_a_wire, addr_b_wire;
 wire we_a_wire, we_b_wire;
 wire [15:0] q_a_wire, q_b_wire;
 
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
regflag flags(.D_in(write_flags), .wEnable(fsm_flag_enable), .reset(reset), .clk(clk), .r(read_flags));

//ALU
ALU alu(.r1(mux1_wire), .r2(mux3_wire), .rout(out), .opcode(opcode), .flags_in(read_flags), .flags_out(write_flags));

//tristatebuffer
tristatebuffer tristatebuffer1(.Dout_mem(q_a_wire), .Alu_mux_cntrl(buff_en), .Alu_out(out), .out(buff_out));


//pc mux
pc_mux mux_pc(.immediate(pc_mux_immediate), .pc_mux_en(pc_mux_en), .data_in(q_a_wire), .out(pc_mux_out));

//program counter
program_counter pc(.in_pc(pc_mux_out), .en_pc(fsm_pc_en), .pc_result(addr_a_wire), .reset(reset) , .clk(clk));

//bram
bram ram(.data_a(mux1_wire), .data_b(data_b_wire), .addr_a(ls_out), .addr_b(addr_b_wire), .we_a(we_a_wire), .we_b(we_b_wire), .clk(clk), .q_a(q_a_wire), .q_b(q_b_wire));


//decoder

decoder decoder(.raw_instructions(IR_out), .opcode(opcode), .rdst(rdst), .rsrc(rsrc), .immediate(ram_immediate), .flag_type(flag_type));


//global_fsm
global_fsm global_fsm(.clk(clk), .reset(reset), .we_enable(we_a_wire), .opcode_in(opcode), .rdst_in(rdst_translated), .rsrc_in(rsrc_translated), .immediate_in(ram_immediate), .immediate_out(fsm_immediate), .pc_mux_en(pc_mux_en), .rdst_out(control2), .rsrc_out(control1), .flags(read_flags), .flag_type(flag_type), .pc_en(fsm_pc_en), .flag_enable(fsm_flag_enable), .imm_mux(imm_control), .tristate_en(buff_en), .opcode_out(fsm_opcode_out), .IR_enable(IR_enable), .ls_control(ls_control), .rdst_write_out(enable), .rdst_write_in(rdst_out_write_wire)) ;
// needs ls control
// rdst_out_wire

//translator
translate translate(.rsrc_in(rsrc), .rdst_in(rdst), .rsrc_out(rsrc_translated), .rdst_out(rdst_translated), .rdst_out_write(rdst_out_write_wire));

//IR
IR IR(.D_in(q_a_wire), .wEnable(IR_enable), .reset(reset), .clk(clk), .r(IR_out));

//LS control
ls_mux ls_mux(.rdst_addr(mux2_wire), .control(ls_control), .pc_addr(addr_a_wire), .out(ls_out));




endmodule
