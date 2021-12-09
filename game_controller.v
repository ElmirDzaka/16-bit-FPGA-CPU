module game_controller(right, left, up, down, movement);

input right, left, up, down; //Inputs from the buttons
output reg[15:0] movement = 0; //Type of movement the user wants

//Dummy Values
//Left = 1, Right = 2, Up = 3, Down = 4


always@(right, left, up, down) begin


    if(right) begin

        movement = 1;

    end

    else if(left) begin

        movement = 2;

    end

    else if(up) begin

        movement = 8;

    end

    else if(down) begin

        movement = 4;

    end

    else begin

        movement = 0;

    end

end

endmodule 