module display5461AS1 (
    input clk,
    input en,
    input [3:0] luminance, // Set the lighting period to a multiple of `2 ^ (15 - luminance)`
    input [15:0] hexx, // 4 hex digits work for display 0 to 9, A, b, C, d, E, F
    input [3:0] points,
    output reg [7:0] segments, // a, b, c, d, e, f, g, dp
    output reg [3:0] digits // D4, D3, D2, D1
);

wire [31:0] segs;
hex27segs h27s0(hexx[3:0], segs[7:1]);
hex27segs h27s1(hexx[7:4], segs[15:9]);
hex27segs h27s2(hexx[11:8], segs[23:17]);
hex27segs h27s3(hexx[15:12], segs[31:25]);
assign segs[0] = points[0];
assign segs[8] = points[1];
assign segs[16] = points[2];
assign segs[24] = points[3];
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
        digits <= {digits[2:0], digits[3]};
        case (digits)
            4'b0001: segments <= segs[15:8];
            4'b0010: segments <= segs[23:16];
            4'b0100: segments <= segs[31:24];
            4'b1000: segments <= segs[7:0];
            default: digits <= 4'b1000;
        endcase
    end
    else segments <= 8'b0;
end

endmodule
