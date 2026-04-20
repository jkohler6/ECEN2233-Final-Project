module DFF (
    input logic D,    // Data input
    input logic clk,  // Clock signal
    input logic rst,  // Asynchronous reset (active high)
    output logic Q,   // Data output
    output logic Qn   // Inverted output
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            Q  <= 1'b0;
            Qn <= 1'b1;
        end else begin
            Q  <= D;
            Qn <= ~D;
        end
    end

endmodule