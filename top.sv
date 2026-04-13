module top (
	input logic sysclk_125mhz,
	input logic [3:0] btn,
	output logic [3:0] sseg_an,
	output logic [7:0] ssegout,
	output logic [5:0] led
);

	logic divd_clk;
	logic debounce_clk;
	logic rst_btn;
	/* 
	* I need to find a way to handle multiple buttons as an input
	*/
	
	clock_divider clk_div(
		.clk(sysclk),
		.div_clk(divd_clk),
		.debounce_clk(debounce_clk)
	);

	/* I need to modify or rremove reset behavior */
	debounce db0( .clk(debounce_clk), .button_in(btn[0]), .button_clean(rst_btn) );
	debounce db1( .clk(debounce_clk), .button_in(btn[1]), .button_clean(rst_btn) );
	debounce db2( .clk(debounce_clk), .button_in(btn[2]), .button_clean(rst_btn) );
	debounce db3( .clk(debounce_clk), .button_in(btn[3]), .button_clean(rst_btn) );
	
endmodule
