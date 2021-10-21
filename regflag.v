module regflag(D_in, wEnable, reset, clk, r);
     input [7:0] D_in;
     input clk, wEnable, reset;
     output reg [7:0] r;

 always @( posedge clk )
    begin
    if (!reset) r <= 8'b00000000; // EDIT to not reset
    else
        begin
            if (wEnable)
                begin
                    r <= D_in;
                end
            else
                begin
                    r <= r;
                end
        end
    end
endmodule
