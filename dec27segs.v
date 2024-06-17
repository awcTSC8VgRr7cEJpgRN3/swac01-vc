module hex27segs (
    input [3:0] hex, // 0 to 9, dummy, dummy, dummy, dummy, dummy, off
    output [6:0] segments // a, b, c, d, e, f, g
);

wire a = hex[3];
wire b = hex[2];
wire c = hex[1];
wire d = hex[0];
assign segments[6] = ~b&~d | a&~b | ~a&b&d | ~a&c&d;
assign segments[5] = ~a&c&d | ~c&~d | ~b;
assign segments[4] = ~c | ~a&b | ~a&d;
assign segments[3] = b&~c&d | ~b&~d | ~b&c | c&~d;
assign segments[2] = ~b&~d | c&~d;
assign segments[1] = ~c&~d | b&~c | b&~d | a&~b;
assign segments[0] = ~b&c | b&~c | a&~b | c&~d;

endmodule
