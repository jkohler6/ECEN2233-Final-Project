module top_thunderbird #(
    parameter int CLK_FREQ_HZ = 125_000_000,
    parameter int STEP_HZ     = 2
) (
    input  logic       sysclk_125mhz,
    input  logic [3:0] btn,
    output logic [7:0] led,
    output logic [6:0] seg,
    output logic [3:0] an
);
    // Button assignment requested:
    // btn[3] = LEFT
    // btn[2] = BRAKE
    // btn[1] = RESET
    // btn[0] = RIGHT
    // Hazard = btn[3] and btn[0] together

    logic       step_tick;
    logic [5:0] lights;
    logic [3:0] mode;

    clock_divider #(
        .CLK_FREQ_HZ(CLK_FREQ_HZ),
        .STEP_HZ(STEP_HZ)
    ) u_div (
        .clk(sysclk_125mhz),
        .reset(btn[1]),
        .step_tick(step_tick)
    );

    thunderbird_fsm u_fsm (
        .clk    (sysclk_125mhz),
        .reset  (btn[1]),
        .step_en(step_tick),
        .left   (btn[3]),
        .right  (btn[0]),
        .brake  (btn[2]),
        .lights (lights),
        .mode   (mode)
    );

    // Board LEDs shown left-to-right as led[7] ... led[0].
    // Put the 6 taillight outputs on led[7:2] so they appear as a 6-LED strip.
    always_comb begin
        led[7:2] = lights;
        led[1]   = step_tick; // useful heartbeat in hardware
        led[0]   = btn[2];    // brake indicator
    end

    seven_seg_decoder u_seven_seg (
        .mode(mode),
        .seg(seg),
        .an (an)
    );
endmodule
