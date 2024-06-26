module swac01 (
    input gclk, // 4M Hz.
    input [2:0] keypadc,
    output switch,
    output [3:0] keypadr,
    output [7:0] segments,
    output [3:0] digits
);

parameter clk_freq = 22'd3_999_999;
// reg [0:0] state = 1'b1; // { countdown }
reg [21:0] clk_counter;
wire [15:0] decs;
wire load;

always @(posedge gclk) begin
    if (clk_counter == clk_freq) clk_counter <= 22'd0;
    else clk_counter <= clk_counter + 1;
end

assign keypadr = 4'b1111;
assign load = |keypadc;
assign switch = |decs;

clock clock02 (
    .clk( clk_counter[21] ),
    .load( load ),
    .min_sec( decs )
);

display5461AS1 disp (
    .clk( clk_counter[7] ),
    .decs( decs ),
    .points( 4'b0100 ),
    .segments( segments ),
    .digits( digits )
);

endmodule
