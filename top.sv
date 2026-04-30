module top (
	input logic            sysclk_100mhz,
	input logic            sw,
	input logic      [3:0] btn,
	output logic     [7:0] ssegout,
	output logic     [5:0] led
);
	logic		     [3:0] btn_clean;
	logic 			 [5:0] fsm_out;
	logic                  divd_clk;
	logic                  debounce_clk;
	
	clock_divider clk_div(
		.clk(sysclk_100mhz),
		.div_clk(divd_clk),
		.debounce_clk(debounce_clk)
	);

	genvar i;
	generate

	for (i = 0; i < 4; i++) begin : debounce_gen
		debounce dbi(
			.clk(debounce_clk),
			.rst(sw),
			.button_in(btn[i]),
			.button_clean(btn_clean[i])
		);
    end
	endgenerate

	tbird_fsm fsm(
		.clk(divd_clk),
		.rst(sw),
		.in(btn_clean[3:0]),
		.out(led)
	);

	sevenseg_hex sev(
		.in(led[5:0]),
		.dp_in(1'b0),
		.ssegout(ssegout)
	);
endmodule
