module dffarray #(parameter WIDTH = 4) (
    input  logic              clk,
    input  logic              rst,
    input  logic [WIDTH-1:0]  d_in,
    output logic [WIDTH-1:0]  q_out
);

    // Using a generate loop to create multiple instances
    genvar i;
    generate
        for (i = 0; i < WIDTH; i++) begin : dff_gen
            DFF u_dff (
                .clk     (clk),
                .rst     (rst),
                .D    (d_in[i]),
                .Q   (q_out[i])
            );
        end
    endgenerate

endmodule