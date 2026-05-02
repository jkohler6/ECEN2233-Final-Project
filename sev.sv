// sevenseg_hex.sv
// ssegout[7:0] = [a b c d e f g dp]  (active-LOW)

module sevenseg_hex (
    input  logic [5:0] in,
    input  logic       dp_in,     // 0 = dp ON, 1 = dp OFF (active-low)
    output logic [7:0] ssegout
);
    logic [6:0] seg; // [a b c d e f g] active-low

    always_comb begin
        case (in)
        6'b000000: seg = 7'b1111111;
        6'b001000,
        6'b011000,
        6'b111000: seg = 7'b1110001;
        6'b000100,
        6'b000110,
        6'b000111: seg = 7'b1111000;
        6'b001100,
        6'b011110: seg = 7'b0001001;
        6'b111111: seg = 7'b0000011;
        default:   seg = 7'b1111111;
        endcase
    end

    // Pack as [a b c d e f g dp]
    always_comb begin
        ssegout[7:1] = seg;
        ssegout[0]   = dp_in;
    end
endmodule
