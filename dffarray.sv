module dffarray #(parameter WIDTH = 4) (
    input  logic              clk,
    input  logic              rst,
    input  logic [WIDTH-1:0]  Q,
    output logic [WIDTH-1:0]  Qn
);

    // Using a generate loop to create multiple instances
    genvar i;
    generate
        for (i = 0; i < WIDTH; i++) begin : dff_gen
            d_flipflop u_dff (
                .clk   (clk),
                .rst (rst_n),
                .Q    (Q[i]),
                .Qn  (Qn[i])
            );
        end
    endgenerate

endmodule