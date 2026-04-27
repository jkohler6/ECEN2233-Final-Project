module debounce (
	input logic clk,
	input logic rst,
	input logic button_in,
	output logic button_clean
	);
	logic [7:0] shift;

	always_ff @ ( posedge clk or posedge rst ) begin
		if (rst) begin
			shift <= 0;
			button_clean <= 0;
		end else begin
			shift <= {shift[6:0], button_in};

			if (&shift)
				button_clean <= 1;
			else if (~|shift)
				button_clean <= 0;
		end
	end

endmodule