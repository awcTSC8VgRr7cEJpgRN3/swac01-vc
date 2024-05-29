module hex27segs (
    input [3:0] hex,
    output [6:0] segments // a, b, c, d, e, f, g
);

wire a = hex[3];
wire b = hex[2];
wire c = hex[1];
wire d = hex[0];
assign segments[6] = a&~b&~c | ~a&b&d | ~b&~d | ~a&c | a&~d | b&c;
assign segments[5] = ~a&~c&~d | ~a&c&d | a&~c&d | ~b&~d | ~a&~b;
assign segments[4] = ~c&d | ~a&b | a&~b | ~a&d | ~a&~c;
assign segments[3] = b&~c&d | a&~c | b&c&~d | ~b&c&d | ~a&~b&~d;
assign segments[2] = ~b&~d | c&~d | a&c | a&b;
assign segments[1] = ~a&b&~c | ~c&~d | b&~d | a&~b | a&c;
assign segments[0] = ~b&c | a&~b | a&d | c&~d | ~a&b&~c;

endmodule
