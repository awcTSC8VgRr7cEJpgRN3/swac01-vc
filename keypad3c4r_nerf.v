module keypad3c4r (
    input clk, // Suggestion: below 50 Hz.
    input en,
    input [2:0] keypadc, // They should receive signals when specific keys are pressed.
    output reg [3:0] keypadr, // They should send signals in turns.
    output reg [3:0] key // 0 to 9, `*`, `#`, null, null, null, null
);

always @(posedge clk) begin
    if (en) begin
        casez (keypadr)
            4'b???1: begin
                casez (keypadc)
                    3'b??1: key <= 4'h1;
                    3'b?1?: key <= 4'h2;
                    3'b1??: key <= 4'h3;
                    default: begin
                        key <= 4'hf;
                        keypadr <= 4'b0010;
                    end
                endcase
            end
            4'b??1?: begin
                casez (keypadc)
                    3'b??1: key <= 4'h4;
                    3'b?1?: key <= 4'h5;
                    3'b1??: key <= 4'h6;
                    default: begin
                        key <= 4'hf;
                        keypadr <= 4'b0100;
                    end
                endcase
            end
            4'b?1??: begin
                casez (keypadc)
                    3'b??1: key <= 4'h7;
                    3'b?1?: key <= 4'h8;
                    3'b1??: key <= 4'h9;
                    default: begin
                        key <= 4'hf;
                        keypadr <= 4'b1000;
                    end
                endcase
            end
            4'b1???: begin
                casez (keypadc)
                    3'b??1: key <= 4'ha;
                    3'b?1?: key <= 4'h0;
                    3'b1??: key <= 4'hb;
                    default: begin
                        key <= 4'hf;
                        keypadr <= 4'b0001;
                    end
                endcase
            end
            default: keypadr <= 4'b0001;
        endcase
    end
end

endmodule
