module clock (
    input clk, // 1 Hz per sec.
    input load,
    input [7:0] load_minute,
    output reg [7:0] minute,
    output reg [7:0] second
);

parameter sec_in_min = 8'h59;

always @(posedge clk, posedge load) begin
    if (load) begin
        minute <= load_minute;
    end
    else begin
        if (second[3:0]) begin
            second[3:0] <= second[3:0] - 1;
        end
        else if (second[7:4]) begin
            second[3:0] <= sec_in_min[3:0];
            second[7:4] <= second[7:4] - 1;
        end
        else if (minute[3:0]) begin
            second <= sec_in_min;
            minute[3:0] <= minute[3:0] - 1;
        end
        else if (minute[7:4]) begin
            { minute[3:0], second } <= { sec_in_min[3:0], sec_in_min };
            minute[7:4] <= minute[7:4] - 1;
        end
    end
end

endmodule
