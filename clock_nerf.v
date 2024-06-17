module clock (
    input clk, // 4M Hz
    input load,
    input [6:0] load_minute,
    output reg [6:0] minute,
    output reg [5:0] second
);

parameter sec_in_min = 6'd59;

always @(posedge clk, posedge load) begin
    if (load) begin
        minute <= load_minute;
    end
    else begin
        if (second) begin
            second <= second - 6'd1;
        end
        else if (minute) begin
            second <= sec_in_min;
            minute <= minute - 7'd1;
        end
    end
end

endmodule
