module display5461AS1 (
    input clk,
    input en,
    input [3:0] luminance, // Set the lighting period to a multiple of `2 ^ (15 - luminance)`
    input [15:0] hexx, // 4 hex digits work for display 0 to 9, A, b, C, d, E, F
    input [3:0] points,
    output reg [7:0] segments, // a, b, c, d, e, f, g, dp
    output reg [3:0] digits // State D4, D3, D2, D1
);

reg [3:0] hex;
reg [7:1] segs;
hex27segs h27s(
    .hex( hex ),
    .segments( segs )
);

reg [14:0] pwm_counter;
reg turn_on;

integer i;
always @(*) begin
    turn_on = 1'b1;
    for (i = 1; i <= 15 - luminance; i = i + 1) begin
        turn_on = turn_on & pwm_counter[ i-1 ];
    end
end

always @(posedge clk) begin
    pwm_counter <= pwm_counter + 1;
    if (en && turn_on) begin
        segments[7:1] <= segs;
        digits <= {digits[2:0], digits[3]};
        case (digits)
            4'b0001: begin hex <= hexx[11:8]; segments[0] <= points[1]; end
            4'b0010: begin hex <= hexx[15:12]; segments[0] <= points[2]; end
            4'b0100: begin hex <= hexx[3:0]; segments[0] <= points[3]; end
            4'b1000: begin hex <= hexx[7:4]; segments[0] <= points[0]; end
            default: digits <= 4'b1000;
        endcase
    end
    else segments <= 8'b0;
end

endmodule
