module clock (
    input clk, // 4M Hz
    input pause,
    input load,
    input [6:0] load_minute,
    output reg [6:0] minute,
    output reg [5:0] second
);

parameter clk_freq = 22'd3_999_999;
parameter sec_in_min = 6'd59;
reg [21:0] clk_counter = 22'd0;

always @(posedge clk, posedge load) begin
    if (load) begin
        minute <= load_minute;
    end
    else if (~pause) begin
        if (clk_counter == clk_freq) begin
            clk_counter <= 22'd0;
            if (second) begin
                second <= second - 6'd1;
            end
            else if (minute) begin
                second <= sec_in_min;
                minute <= minute - 7'd1;
            end
        end
        else begin
            clk_counter <= clk_counter + 22'd1;
        end
    end
end

endmodule
