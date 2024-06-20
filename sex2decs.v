module sex2decs (
    input [5:0] sexagesimal, // 0 to 63
    output [6:0] decs // 2 digits but 3 bits are needed for the highest digit.
);

wire a = sexagesimal[5];
wire b = sexagesimal[4];
wire c = sexagesimal[3];
wire d = sexagesimal[2];
wire e = sexagesimal[1];
wire f = sexagesimal[0];
assign decs[6] = a&c | a&b;
assign decs[5] = a&~b&~c | ~a&b&d | ~a&b&c | b&c&d;
assign decs[4] = ~a&b&~c&~d | ~a&~b&c&e | ~a&~b&c&d | ~a&c&d&e | a&b&c&~d | a&~b&~c | a&~c&d | b&~c&~d&e;
assign decs[3] = ~a&~b&c&~d&~e | ~a&b&~c&~d&e | a&b&~c&~d&~e | ~a&b&c&d&~e | a&~b&~c&d&e | a&b&c&~d&e;
assign decs[2] = a&~b&~c&~d&e | a&b&~c&d&e | ~a&b&~d&~e | ~a&b&c&~d | b&c&~d&~e | ~b&c&d&e | a&~b&d&~e | ~a&~b&~c&d;
assign decs[1] = ~a&b&~c&~d&~e | ~a&~b&c&d&~e | ~a&b&c&~d&e | a&b&c&~d&~e | ~a&~b&~c&e | a&~b&~c&~e | ~a&~c&d&e | a&~c&d&~e | a&~b&c&e | a&c&d&e;
assign decs[0] = f;

endmodule
