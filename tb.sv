`timescale 1ns / 1ps

module tb ();
	logic	clk;
	logic [3:0] btn;
	logic [5:0] led;
	logic [6:0] seg;
	logic [3:0] an;

	top #(
		.CLK_FREQ_HZ(20),
		.STEP_HZ(2)
	) UUT (
		.sysclk_125mhz(clk),
		.btn(btn),
		.led(led),
		.seg(seg),
		.an(an)
	);

	localparam logic [3:0] MODE_IDLE   = 4'd0;
    	localparam logic [3:0] MODE_LEFT   = 4'd1;
    	localparam logic [3:0] MODE_RIGHT  = 4'd2;
    	localparam logic [3:0] MODE_HAZARD = 4'd3;
    	localparam logic [3:0] MODE_BRAKE  = 4'd4;

	initial clk = 1'b0;
	always #5 clk = ~clk;

	task automatic check_outputs(
		input logic [5:0] exp_lights,
		input logic [3:0] exp_mode,
		input string	  label
	);



