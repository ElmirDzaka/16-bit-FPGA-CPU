// File for IR Immediate Register
module IR(D_in, wEnable, reset, clk, r);
     input [15:0] D_in;
     input clk, wEnable, reset;
     output reg [15:0] r;

 always @(D_in, wEnable) //Used to be posedge 
    //if (!reset) r <= 16'b0000000000000000; // EDIT to not reset
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
endmodule
