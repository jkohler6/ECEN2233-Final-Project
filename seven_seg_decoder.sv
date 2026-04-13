module seven_seg_decoder #(
    parameter bit ACTIVE_LOW = 1'b1
) (
    input  logic [3:0] mode,
    output logic [6:0] seg,
    output logic [3:0] an
);
    logic [6:0] seg_raw;

    // One digit enabled. Display mode code directly: 0=IDLE, 1=LEFT, 2=RIGHT, 3=HAZARD, 4=BRAKE
    always_comb begin
        unique case (mode)
            4'h0: seg_raw = 7'b1111110; // 0
            4'h1: seg_raw = 7'b0110000; // 1
            4'h2: seg_raw = 7'b1101101; // 2
            4'h3: seg_raw = 7'b1111001; // 3
            4'h4: seg_raw = 7'b0110011; // 4
            default: seg_raw = 7'b0000001; // '-'
        endcase

        if (ACTIVE_LOW) begin
            seg = ~seg_raw;
            an  = 4'b1110;
        end else begin
            seg = seg_raw;
            an  = 4'b0001;
        end
    end
endmodule
