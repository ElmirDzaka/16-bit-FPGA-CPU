//module tristatebuffer(inp, en, out);
//
//input [15:0] inp;
//input en;
//
//output reg [15:0] out;
//
////assign out = en?inp:16'bx;
//always @(inp, en) begin
//         out = en?inp:16'bx;
//end
//
//endmodule

module tristatebuffer(Dout_mem, Alu_mux_cntrl, Alu_out, out);

input [15:0] Dout_mem;
input Alu_mux_cntrl;
input [15:0] Alu_out;
output reg [15:0] out;



//always @(control, immediate) begin
//    if(control) begin
//        out = immediate;
//    end
//    else begin
//        out = data_in; // do nothing
//    end

        always @(*) begin

            out = Alu_mux_cntrl ? Dout_mem : Alu_out;





end
endmodule