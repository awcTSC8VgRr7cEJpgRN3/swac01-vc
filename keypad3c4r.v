module keypad3c4r (
    input [2:0] keypadc, // They should receive signals when specific keys are pressed.
    output [3:0] keypadr, // They should send signals in turns.
    output [9:0] numbers, // Whether the numbers 9 to 0 are pressed.
    output asterisk, // Whether the star are pressed.
    output hash // Whether the pound are pressed.
);



endmodule
