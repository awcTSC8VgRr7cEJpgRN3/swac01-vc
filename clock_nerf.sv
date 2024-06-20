module clock (
    input clk, // 1 Hz per sec.
    input load,
    output [15:0] min_sec
);

parameter sec_in_min = 6'd59;
reg [5:0] minute;
reg [5:0] second;

assign min_sec[15:12] = minute / 10;
assign min_sec[11:8] = minute - min_sec[15:12];
assign min_sec[7:4] = second / 10;
assign min_sec[3:0] = second - min_sec[7:4];

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
