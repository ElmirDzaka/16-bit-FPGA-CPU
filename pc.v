module Pc(PCNext, PCResult, Reset, Clk,PCen);

    input       [47:0]  PCNext;
    input               Reset, Clk,PCen;

    output reg  [47:0]  PCResult;

    /* Please fill in the implementation here... */

    initial begin

        PCResult <= 48'h00000000;
    end

    always @(posedge Clk)
    begin
        if (Reset == 1)
        begin
            PCResult <= 48'h00000000;
        end
        else
        begin
            if (PCen == 1) begin
                PCResult <= PCNext;
            end
        end

        //$display("PC=%h",PCResult);
    end

endmodule 