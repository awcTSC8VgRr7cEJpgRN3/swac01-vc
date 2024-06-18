module swac01 (
    input gclk, // 4M Hz.
    input [2:0] keypadc,
    output reg switch,
    output [3:0] keypadr,
    output [7:0] segments,
    output [3:0] digits
);

parameter clk_freq = 22'd3_999_999;
// reg [0:0] state = 1'b1; // { countdown }
reg [21:0] clk_counter;
wire [6:0] minute;
wire [5:0] second;
wire [15:0] hexx;

always @(posedge gclk) begin
    if (clk_counter == clk_freq) clk_counter <= 22'd0;
    else clk_counter <= clk_counter + 22'd1;
end

num2decs num2decs_min (
    .number( minute ),
    .decimals( hexx[15:8] )
);

num2decs num2decs_sec (
    .number( second ),
    .decimals( hexx[7:0] )
);

/*
clock clock01 (
    .clk( gclk ),
    .pause( 1'b0 ),
    .load( 1'b0 ),
    .load_minute( 7'd0 ),
    .minute( minute ),
    .second( second )
);
*/

clock clock02 (
    .clk( clk_counter[21] ),
    .load( 1'b1 ),
    .load_minute( 7'd1 ),
    .minute( minute ),
    .second( second )
);

display5461AS1 disp (
    .clk( clk_counter[7] ),
    .en( 1'b1 ),
    .luminance( 4'd11 ),
    .hexx( hexx ),
    .points( 4'b0100 ),
    .segments( segments ),
    .digits( digits )
);

/*
keypad3c4r keypad (
    .clk( clk_counter[10] ),
    .en( 1'b1 ),
    .keypadc( keypadc ),
    .keypadr( keypadr ),
    .numbers( test4[9:0] ),
    .asterisk( test4[10] ),
    .hash( test4[11] )
);
*/

keypad3c4r keypad (
    .clk( clk_counter[17] ),
    .en( 1'b1 ),
    .keypadc( keypadc ),
    .keypadr( keypadr ),
    .key( test3 )
);

endmodule
