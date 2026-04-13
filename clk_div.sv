module clock_divider (
	input logic clk,
	output logic div_clk,
	output logic debounce_clk 
);
	logic[31:0] div;
	
	always_ff @(posedge clk) begin
		div <= div + 1;
	end

	assign div_clk = div[24];
	assign debounce_clk = div[4];

endmodule