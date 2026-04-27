module top (
	input logic sysclk_125mhz,
	input logic [4:0] btn,
	output logic [7:0] ssegout,
	output logic [5:0] led
);
	logic				 [4:0] btn_clean;
	logic 			 [5:0] fsm_out;
	clock_divider clk_div(
		.clk(sysclk),
		.div_clk(divd_clk),
		.debounce_clk(debounce_clk)
	);

	genvar i;
	generate

	for (i = 0; i < 5; i++) begin
		debounce dbi(
			.clk(debounce_clk),
			.button_in(btn[i]),
			.button_clean(btn_clean[i])
		);
    end
	endgenerate

	tbird_fsm fsm(
		.clk(divd_clk),
		.rst(btn_clean[4]),
		.in(btn_clean[3:0]),
		.out(led)
	);

	sevenseg_hex sev(
		.in(fsm_out[5:0]),
		.dp_in(1'b0),
		.ssegout(ssegout)
	);
endmodule
