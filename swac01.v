module swac01 (
    input gclk,
    input [2:0] keypadc,
    output switch,
    output [3:0] keypadr,
    output [7:0] segments,
    output [3:0] digits
);

reg [10:0] clk_counter;
wire [15:0] test2;
wire [11:0] test4;

always @(posedge gclk) begin
    clk_counter <= clk_counter + 1;
end

display5461AS1 disp (
    .clk( clk_counter[7] ),
    .en( 1'b1 ),
    .luminance( 4'd11 ),
    .mask( 4'b1000 ),
    .hexx( test2 ),
    .points( 4'b1000 ),
    .segments( segments ),
    .digits( digits )
);

keypad3c4r keypad (
    .clk( clk_counter[10] ),
    .en( 1'b1 ),
    .keypadc( keypadc ),
    .keypadr( keypadr ),
    .numbers( test4[9:0] ),
    .asterisk( test4[10] ),
    .hash( test4[11] )
);

assign test2 = { 4'b0, test4 };

endmodule
