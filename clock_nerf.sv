module clock (
    input clk, // 1 Hz per sec.
    input load,
    output [15:0] min_sec
);

parameter sec_in_min = 6'd59;
reg [5:0] minute;
reg [5:0] second;

sex2decs s2d_min (
    .sexagesimal( minute ),
    .decs( min_sec[14:8] )
);

sex2decs s2d_sec (
    .sexagesimal( second ),
    .decs( min_sec[6:0] )
);

always @(posedge clk) begin
    if (load) begin
        minute <= minute + 1;
    end
    else if (second) begin
        second <= second - 1;
    end
    else if (minute) begin
        second <= sec_in_min;
        minute <= minute - 1;
    end
end

endmodule
