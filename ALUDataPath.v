module ALUDataPath(clk, reset, left, right, down, up);

input clk;
input reset;

// Controller input
input left;
input right;
input down;
input up;

//Enable signal from arduino
//input pump;
//input dump;
//output reg [6:0]z;

//output [15:0]matrix_out;

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
wire [4:0] rdst_translated;
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
wire [15:0] translate_out_imm;
wire [15:0] fsm_out_imm;



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
wire [7:0] pc_mux_immediate;
wire pc_mux_en;
wire [15:0] pc_mux_data_in;
wire [15:0] pc_mux_out;

//bram wires
 wire [15:0] data_a_wire, data_b_wire;
 wire [15:0] addr_a_wire, addr_b_wire;
 wire we_a_wire, we_b_wire;
 wire [15:0] q_a_wire, q_b_wire;
 
//program counter wires
wire en_pc_wire;
//wire [15:0] pc_result;

//decoder fsm wires

wire [15:0] dis_to_pc;
wire [15:0] game_contrler_output;




//regbank
RegBank RegBank0(.ALUBus(buff_out),.player_input(game_contrler_output), .r0(r0_wire), .r1(r1_wire), .r2(r2_wire), .r3(r3_wire), .r4(r4_wire), .r5(r5_wire), .r6(r6_wire), .r7(r7_wire), .r8(r8_wire), .r9(r9_wire), .r10(r10_wire), .r11(r11_wire), .r12(r12_wire), .r13(r13_wire), .r14(r14_wire), .r15(r15_wire), .regEnable(enable), .clk(clk), .reset(reset));

//mux1
mux mux1(.control(control1), .out(mux1_wire), .r0(r0_wire), .r1(r1_wire), .r2(r2_wire), .r3(r3_wire), .r4(r4_wire), .r5(r5_wire), .r6(r6_wire), .r7(r7_wire), .r8(r8_wire), .r9(r9_wire), .r10(r10_wire)
, .r11(r11_wire), .r12(r12_wire), .r13(r13_wire), .r14(r14_wire), .r15(r15_wire));

//mux2
mux mux2(.control(control2), .out(mux2_wire), .r0(r0_wire), .r1(r1_wire), .r2(r2_wire), .r3(r3_wire), .r4(r4_wire), .r5(r5_wire), .r6(r6_wire), .r7(r7_wire), .r8(r8_wire), .r9(r9_wire), .r10(r10_wire)
, .r11(r11_wire), .r12(r12_wire), .r13(r13_wire), .r14(r14_wire), .r15(r15_wire));

//immediate mux
imm_mux mux3(.immediate(fsm_out_imm),.control(imm_control), .data_in(mux2_wire), .out(mux3_wire));

//regflag // edit output to fsm
regflag flags(.D_in(write_flags), .wEnable(fsm_flag_enable), .reset(reset), .clk(clk), .r(read_flags));

//ALU
ALU alu(.r1(mux1_wire), .r2(mux3_wire), .rout(out), .opcode(opcode), .flags_in(read_flags), .flags_out(write_flags));

//tristatebuffer
tristatebuffer tristatebuffer1(.Dout_mem(q_a_wire), .Alu_mux_cntrl(buff_en), .Alu_out(out), .out(buff_out));


//pc mux
pc_mux mux_pc(.immediate(dis_to_pc), .pc_mux_en(pc_mux_en), .data_in(addr_a_wire), .out(pc_mux_out));

//program counter
program_counter pc(.in_pc(pc_mux_out), .en_pc(fsm_pc_en), .pc_result(addr_a_wire), .reset(reset) , .clk(clk));

//bram
bram ram(.data_a(mux1_wire), .data_b(data_b_wire), .addr_a(ls_out), .addr_b(addr_b_wire), .we_a(we_a_wire), .we_b(we_b_wire), .clk(clk), .q_a(q_a_wire), .q_b(matrix_out));


//decoder

decoder decoder(.raw_instructions(IR_out), .opcode(opcode), .rdst(rdst), .rsrc(rsrc), .immediate(ram_immediate), .flag_type(flag_type));


//global_fsm
global_fsm global_fsm(.clk(clk), .reset(reset), .we_enable(we_a_wire), .opcode_in(opcode), .rdst_in(rdst_translated), .rsrc_in(rsrc_translated), .immediate_in(translate_out_imm), .immediate_out(fsm_out_imm), .pc_mux_en(pc_mux_en), .rdst_out(control2), .rsrc_out(control1), .flags(read_flags), .flag_type(flag_type), .pc_en(fsm_pc_en), .flag_enable(fsm_flag_enable), .imm_mux(imm_control), .tristate_en(buff_en), .opcode_out(fsm_opcode_out), .IR_enable(IR_enable), .ls_control(ls_control), .rdst_write_out(enable), .rdst_write_in(rdst_out_write_wire)) ;
// needs ls control
// rdst_out_wire

//translator
translate translate(.rsrc_in(rsrc), .rdst_in(rdst), .rsrc_out(rsrc_translated), .rdst_out(rdst_translated), .rdst_out_write(rdst_out_write_wire), .imm_in(ram_immediate), .imm_out(translate_out_imm), .flag_type(flag_type));

//IR
IR IR(.D_in(q_a_wire), .wEnable(IR_enable), .reset(reset), .clk(clk), .r(IR_out));

//LS control
ls_mux ls_mux(.rdst_addr(mux2_wire), .control(ls_control), .pc_addr(addr_a_wire), .out(ls_out));

pc_displacement pc_displacement1(.pc_in(addr_a_wire), .imm_in(translate_out_imm), .flags(read_flags),.flag_type(flag_type), .dis_out(dis_to_pc), .condition(rdst));

game_controller game(.right(right), .left(left), .up(up), .down(down), .movement(game_contrler_output));

// LED matrix program counter
//pc_matrix pc_matrix(.clk(clk), .reset_arduino(dump), .pc_result(addr_b_wire), .enable(pump));



//always @*
//case(r0_wire)
//	4'b0000 :			//Hexadecimal 0
//	z = ~7'b0111111;
//   4'b0001 :			//Hexadecimal 1
//	z = ~7'b0000110;
//   4'b0010 :			//Hexadecimal 2
//	z = ~7'b1011011;
//   4'b0011 : 			//Hexadecimal 3
//	z = ~7'b1001111;
//   4'b0100 : 			//Hexadecimal 4
//	z = ~7'b1100110;
//   4'b0101 : 			//Hexadecimal 5
//	z = ~7'b1101101;
//   4'b0110 : 			//Hexadecimal 6
//	z = ~7'b1111101;
//   4'b0111 :			//Hexadecimal 7
//	z = ~7'b0000111;
//   4'b1000 : 			//Hexadecimal 8
//	z = ~7'b1111111;
//   4'b1001 : 			//Hexadecimal 9
//	z = ~7'b1100111;
//	4'b1010 : 			//Hexadecimal A
//	z = ~7'b1110111;
//	4'b1011 : 			//Hexadecimal B
//	z = ~7'b1111100;
//	4'b1100 : 			//Hexadecimal C
//	z = ~7'b1011000;
//	4'b1101 : 			//Hexadecimal D
//	z = ~7'b1011110;
//	4'b1110 : 			//Hexadecimal E
//	z = ~7'b1111001;
//	4'b1111 : 			//Hexadecimal F	
//	z = ~7'b1110001; 
//   default :
//	z = ~7'b0000000;
//	
//endcase




endmodule
