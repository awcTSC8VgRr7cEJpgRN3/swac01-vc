module swac01(
    input gclk,
    input [2:0] keypadc,
    output switch,
    output [3:0] keypadr,
    output [7:0] segments,
    output [3:0] digits
);

reg [7:0] clk_counter;

always @(posedge gclk) begin
    clk_counter <= clk_counter + 1;
end

display5461AS1 disp(clk_counter[7], 1'b1, 4'd11, 16'h3210, 4'b0100, segments, digits);

endmodule
