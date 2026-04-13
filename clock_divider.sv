module clock_divider #(
    parameter int CLK_FREQ_HZ = 125_000_000,
    parameter int STEP_HZ     = 2
) (
    input  logic clk,
    input  logic reset,
    output logic step_tick
);
    localparam int DIVISOR = (STEP_HZ > 0) ? (CLK_FREQ_HZ / STEP_HZ) : 1;
    localparam int COUNT_W = (DIVISOR > 1) ? $clog2(DIVISOR) : 1;

    logic [COUNT_W-1:0] count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count     <= '0;
            step_tick <= 1'b0;
        end else if (count == DIVISOR-1) begin
            count     <= '0;
            step_tick <= 1'b1;
        end else begin
            count     <= count + 1'b1;
            step_tick <= 1'b0;
        end
    end
endmodule
