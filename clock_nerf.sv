module clock (
    input clk, // 1 Hz per sec.
    input load,
    input [7:0] load_minute,
    output reg [15:0] min_sec
);

parameter max = 12'h959;
integer i;

always @(posedge clk, posedge load) begin
    if (load) begin
        min_sec[15:8] <= load_minute;
    end
    else begin
        for ( i = 0; i < 16; i = i + 4 ) begin
            if ( { min_sec[i+3], min_sec[i+2], min_sec[i+1], min_sec[i] } ) break;
        end
        if ( i != 16 ) begin
            // min_sec <= ( ( (min_sec >> i) - 1 ) << i ) | ( ( max << (16-i) ) >> (16-i) );
            min_sec <= ( ( (min_sec >> i) - 1 ) << i ) | ( ( max << (16-i) ) >> (16-i) );
        end
    end
end

endmodule
