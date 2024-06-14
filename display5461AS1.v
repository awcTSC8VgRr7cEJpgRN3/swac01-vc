module display5461AS1 (
    input clk, // Suggestion: above 10000 Hz when the luminance is maximum.
    input en,
    input [3:0] luminance, // Set the lighting period to a multiple of `2 ^ (15 - luminance)`
    input [3:0] show_a2f, // Decimal only when disabled.
    input [15:0] hexx, // 4 hex digits work for display 0 to 9, A, b, C, d, E, F
    input [3:0] points,
    output reg [7:0] segments, // a, b, c, d, e, f, g, dp
    output reg [3:0] digits // State D4, D3, D2, D1
);

reg a2f;
reg [3:0] hex;
wire [7:1] segs;
hex27segs h27s (
    .show_a2f( a2f ),
    .hex( hex ),
    .segments( segs )
);

always @(*) begin
    casez (digits)
        4'b???1: begin a2f = show_a2f[0]; hex = hexx[3:0];   segments = { segs, points[0] }; end
        4'b??1?: begin a2f = show_a2f[1]; hex = hexx[7:4];   segments = { segs, points[1] }; end
        4'b?1??: begin a2f = show_a2f[2]; hex = hexx[11:8];  segments = { segs, points[2] }; end
        4'b1???: begin a2f = show_a2f[3]; hex = hexx[15:12]; segments = { segs, points[3] }; end
        default: segments = 8'b0;
    endcase
end

reg [15:0] pwm_counter;
reg [3:0] digits_next;

always @(posedge clk) begin
    pwm_counter <= pwm_counter + 1;
    if ( en && &( pwm_counter | ~( ( 16'b1 << (15 - luminance) ) - 16'b1 ) ) ) begin // magic `turn_on`.
        digits_next <= { digits_next[2:0], digits_next[3] };
        case (digits_next)
            4'b0001, 4'b0010, 4'b0100, 4'b1000: digits <= digits_next;
            default: digits_next <= 4'b0001;
        endcase
    end
    else digits <= 4'b0;
end

endmodule
