module ls_mux(rdst_addr, control, pc_addr, out);

input [15:0] rdst_addr;
input control;
input [15:0] pc_addr;
output reg [15:0] out;


    always @(*) begin

            out = control ? rdst_addr :  pc_addr;

    end

endmodule
