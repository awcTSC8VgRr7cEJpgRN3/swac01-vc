module keypad3c4r (
    input clk, // Suggestion: above 4000 Hz when the `debounce_level_target` is 32.
    input en,
    input [2:0] keypadc, // They should receive signals when specific keys are pressed.
    output reg [3:0] keypadr, // They should send signals in turns.
    output reg [9:0] numbers, // Whether the numbers 9 to 0 are pressed.
    output reg asterisk, // Whether the star are pressed.
    output reg hash // Whether the pound are pressed.
);

parameter debounce_level_target = 6'd20;
reg [5:0] debounce_level;
reg [11:0] state_prev; // `#`, `*`, 9 to 0

always @(posedge clk) begin
    if (en) begin
        keypadr <= { keypadr[2:0], keypadr[3] };
        case (keypadr)
            4'b0001: begin
                state_prev[3:1] <= keypadc;
                if (keypadc == state_prev[3:1]) begin
                    if (debounce_level == debounce_level_target - 6'd1) begin
                        debounce_level <= 6'd0;
                        { hash, asterisk, numbers } <= state_prev;
                    end
                    else debounce_level <= debounce_level + 6'd1;
                end
                else debounce_level <= 6'd0;
            end
            4'b0010: begin
                state_prev[6:4] <= keypadc;
                if (keypadc == state_prev[6:4]) begin
                    if (debounce_level == debounce_level_target - 6'd1) begin
                        debounce_level <= 6'd0;
                        { hash, asterisk, numbers } <= state_prev;
                    end
                    else debounce_level <= debounce_level + 6'd1;
                end
                else debounce_level <= 6'd0;
            end
            4'b0100: begin
                state_prev[9:7] <= keypadc;
                if (keypadc == state_prev[9:7]) begin
                    if (debounce_level == debounce_level_target - 6'd1) begin
                        debounce_level <= 6'd0;
                        { hash, asterisk, numbers } <= state_prev;
                    end
                    else debounce_level <= debounce_level + 6'd1;
                end
                else debounce_level <= 6'd0;
            end
            4'b1000: begin
                { state_prev[11], state_prev[0], state_prev[10] } <= keypadc;
                if (keypadc == { state_prev[11], state_prev[0], state_prev[10] }) begin
                    if (debounce_level == debounce_level_target - 6'd1) begin
                        debounce_level <= 6'd0;
                        { hash, asterisk, numbers } <= state_prev;
                    end
                    else debounce_level <= debounce_level + 6'd1;
                end
                else debounce_level <= 6'd0;
            end
            default: keypadr <= 4'b0001;
        endcase
    end
end

endmodule
