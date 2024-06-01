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
wire [7:1] segs;
hex27segs h27s(
    .hex( hex ),
    .segments( segs )
);

always @(*) begin
    case (digits)
        4'b0001: begin hex = hexx[3:0];   segments = { segs, points[0] }; end
        4'b0010: begin hex = hexx[7:4];   segments = { segs, points[1] }; end
        4'b0100: begin hex = hexx[11:8];  segments = { segs, points[2] }; end
        4'b1000: begin hex = hexx[15:12]; segments = { segs, points[3] }; end
        default: segments = 8'b0;
    endcase
end

reg [14:0] pwm_counter;
reg turn_on;
reg [3:0] digits_next;

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
        digits_next <= { digits_next[2:0], digits_next[3] };
        case (digits_next)
            4'b0001: digits <= digits_next;
            4'b0010: digits <= digits_next;
            4'b0100: digits <= digits_next;
            4'b1000: digits <= digits_next;
            default: digits_next <= 4'b0001;
        endcase
    end
    else digits <= 4'b0;
end

endmodule
