/*
Modes

Reset Mode:
All lights OFF
FSM goes to IDLE

Left Turn
Left lights flash
Continues even if button is released
Right turn is the same


*/

module fsm (
	input logic rst,
	input logic left,
	input logic right,
    input logic right,
    output logic mode,
	output logic [2:0] sev
);
	always_ff @ (posedge clk) begin
		if (rst)
			q <= 8'b0;
		else if (en)
			q <= q + 1;
	end

endmodule