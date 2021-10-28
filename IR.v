// File for IR Immediate Register
module IR(D_in, wEnable, reset, clk, r);
     input [15:0] D_in;
     input clk, wEnable, reset;
     output reg [15:0] r;

 always @( posedge clk )
    begin
    if (!reset) r <= 8'b00000000; // EDIT to not reset
    else
        begin
            if (wEnable)
                begin
                    r <= D_in; // If enable High, Store immediate instruction
                end
            else
                begin
                    r <= r;   //  Otherwise keep the current instruction
                end
        end
    end
endmodule