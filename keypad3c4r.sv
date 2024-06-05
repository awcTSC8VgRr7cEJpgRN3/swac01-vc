module keypad3c4r (
    input clk, // Suggestion: above 4000 Hz when the `debounce_time` is 8.
    input en,
    input [2:0] keypadc, // They should receive signals when specific keys are pressed.
    output reg [3:0] keypadr, // They should send signals in turns.
    output reg [9:0] numbers, // Whether the numbers 9 to 0 are pressed.
    output reg asterisk, // Whether the star are pressed.
    output reg hash // Whether the pound are pressed.
);

parameter debounce_level_target = 4'd5;
reg [3:0] debounce_level [3:0][2:0]; // 1 to 9, `*`, 0, `#`

integer i;
always @(posedge clk) begin
    if (en) begin
        keypadr <= { keypadr[2:0], keypadr[3] };
        case (keypadr)
            4'b0001: begin
                for ( i = 0; i < 3; i = i + 1 ) begin
                    if ( keypadc[i] ^ numbers[ i + 1 ] ) begin
                        if ( debounce_level[0][i] == debounce_level_target - 4'd1 ) begin
                            debounce_level[0][i] <= 4'd0;
                            numbers[ i + 1 ] <= ~numbers[ i + 1 ];
                        end
                        else debounce_level[0][i] <= debounce_level[0][i] + 4'd1;
                    end
                    else debounce_level[0][i] <= 4'd0;
                end
            end
            4'b0010: begin
                for ( i = 0; i < 3; i = i + 1 ) begin
                    if ( keypadc[i] ^ numbers[ i + 4 ] ) begin
                        if ( debounce_level[1][i] == debounce_level_target - 4'd1 ) begin
                            debounce_level[1][i] <= 4'd0;
                            numbers[ i + 4 ] <= ~numbers[ i + 4 ];
                        end
                        else debounce_level[1][i] <= debounce_level[1][i] + 4'd1;
                    end
                    else debounce_level[1][i] <= 4'd0;
                end
            end
            4'b0100: begin
                for ( i = 0; i < 3; i = i + 1 ) begin
                    if ( keypadc[i] ^ numbers[ i + 7 ] ) begin
                        if ( debounce_level[2][i] == debounce_level_target - 4'd1 ) begin
                            debounce_level[2][i] <= 4'd0;
                            numbers[ i + 7 ] <= ~numbers[ i + 7 ];
                        end
                        else debounce_level[2][i] <= debounce_level[2][i] + 4'd1;
                    end
                    else debounce_level[2][i] <= 4'd0;
                end
            end
            4'b1000: begin
                if ( keypadc[0] ^ asterisk ) begin
                    if ( debounce_level[2][0] == debounce_level_target - 4'd1 ) begin
                        debounce_level[2][0] <= 4'd0;
                        asterisk <= ~asterisk;
                    end
                    else debounce_level[2][0] <= debounce_level[2][0] + 4'd1;
                end
                else debounce_level[2][0] <= 4'd0;
                if ( keypadc[1] ^ numbers[0] ) begin
                    if ( debounce_level[2][1] == debounce_level_target - 4'd1 ) begin
                        debounce_level[2][1] <= 4'd0;
                        numbers[0] <= ~numbers[0];
                    end
                    else debounce_level[2][1] <= debounce_level[2][1] + 4'd1;
                end
                else debounce_level[2][1] <= 4'd0;
                if ( keypadc[2] ^ hash ) begin
                    if ( debounce_level[2][2] == debounce_level_target - 4'd1 ) begin
                        debounce_level[2][2] <= 4'd0;
                        hash <= ~hash;
                    end
                    else debounce_level[2][2] <= debounce_level[2][2] + 4'd1;
                end
                else debounce_level[2][2] <= 4'd0;
            end
            default: keypadr <= 4'b0001;
        endcase
    end
end

endmodule
