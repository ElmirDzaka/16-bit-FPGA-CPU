// Module for the Fibonacci sequence
// Created by Louis J. Cerda on 9/23/2021
// Fibonacci sequnce for reference
// 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144

// ns Logic: Next state transitions

module fsm_sum (clk, reset, immediate, buff_en, enable, control1, control2, imm_control, opcode);

    // Input signals for the FSM
    input clk, reset;
    
    // Enable signals for the data flow
    output reg [15:0] immediate;
   output reg buff_en;
   output reg [15:0]enable;
    output reg [4:0]control1;
    output reg [4:0]control2;
    output reg imm_control;
    output reg [7:0]opcode;

    
    // ps -> Previous state, ns -> Next state
    reg [3:0] ps, ns; 
    
    
    parameter [3:0] s0  = 4'b0000;
   parameter [3:0] s1  = 4'b0001;
   parameter [3:0] s2  = 4'b0010;
   parameter [3:0] s3  = 4'b0011;
   parameter [3:0] s4  = 4'b0100;
       
    //Sequential block, negedge of reset due to push button
    always @ (posedge clk, negedge reset) begin

        if(reset== 0) ps <= s0;
        else ps <= ns;

    end
    
    // Combinational block, responsible fo setting the next state
    always@(posedge clk, negedge reset) begin

        case(ps)
            s0: ns <= s1;
           s1: ns <= s1;
            
            default: ns <= s0;
        endcase
    end


    always@ (ps) begin

        case(ps)
            // Reset muxes, and tristate to 0. 
            // Template for the FSM enable codes
            s0: begin  
                    immediate   = 0;  //Incoming Immediate value              [15:0]
                    enable      = 0;  //Register enable                              [15:0]
                    opcode      = 0;    //Operation code for ALU                 [7: 0]
                    control1    = 0;  //control code for mux on the left      [4: 0]
                    control2    = 0;  //control code for mux on the right     [4: 0]
                    imm_control = 0;  //control code for immediate value      [1bit]
                    buff_en     = 0;  //enable signal for ALU output          [1bit]
                end
                
            // Load value into left register from r0 into ALU
            s1: begin  
                    immediate   = 16'b0000000000000001; // Load 1 from immediate  
                    enable      = 16'b0000000000000010; // write into reg 1                
                    opcode      = 8'b00000101;             // add op    
                    control1    = 5'b00001;             // enable left mux
                    control2    = 0;  
                    imm_control = 1;                    // enable immediate
                    buff_en     = 1;                    // enable datapath
                end
                            
        endcase
    end
endmodule