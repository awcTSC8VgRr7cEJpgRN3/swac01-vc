module num2decs (
    input [6:0] number, // Up to 99.
    output [7:0] decimals // 2 digits.
);

assign decimals[7:4] = number / 10;
assign decimals[3:0] = number % 10;

endmodule
