module display5461AS1 (
    input clk, // Suggestion: above 10000 Hz when the luminance is maximum.
    input [15:0] decs, // 4 dec digits work for display 0 to 9, dummy, dummy, dummy, dummy, dummy, off
    input [3:0] points,
    output reg [7:0] segments, // a, b, c, d, e, f, g, dp
    output reg [3:0] digits // State D4, D3, D2, D1
);

reg [3:0] dec;
wire [7:1] segs;
dec27segs d27s (
    .dec( dec ),
    .segments( segs )
);

always @(*) begin
    casez (digits)
        4'b???1: begin dec = decs[3:0];   segments = { segs, points[0] }; end
        4'b??1?: begin dec = decs[7:4];   segments = { segs, points[1] }; end
        4'b?1??: begin dec = decs[11:8];  segments = { segs, points[2] }; end
        4'b1???: begin dec = decs[15:12]; segments = { segs, points[3] }; end
        default: segments = 8'b0;
    endcase
end

reg [3:0] pwm_counter;
reg [3:0] digits_next;

always @(posedge clk) begin
    pwm_counter <= pwm_counter + 1;
    if (&pwm_counter) begin // magic `turn_on`.
        digits_next <= { digits_next[2:0], digits_next[3] };
        case (digits_next)
            4'b0001, 4'b0010, 4'b0100, 4'b1000: digits <= digits_next;
            default: digits_next <= 4'b0001;
        endcase
    end
    else digits <= 4'b0;
end

endmodule
