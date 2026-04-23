module fsm (
	input logic clk,
	input logic rst,
	input logic [3:0] ctrl,
	output logic [5:0] out,
	output logic [3:0] mode
);

/* Revaluate the need for a control word struct */

typedef enum logic [5:0] {
	ST_IDLE = 6'b000000,
	ST_L1   = 6'b001000,
	ST_L2	= 6'b011000,
	ST_L3   = 6'b111000,
	ST_R1	= 6'b000100,
	ST_R2	= 6'b000110,
	ST_R3	= 6'b000111,
	ST_H1	= 6'b001100,
	ST_H2	= 6'b011110,
	ST_H3	= 6'b111111,
	ST_B	= 6'b111111
} state_t;

state_t current, next;
ctrl_t ctrl;

assign next = state_t'(ctrl.next);

always_ff @(posedge clk or posedge rst) begin
	if (reset)
		current <= ST_IDLE;
	else
		current <= (ctrl == 4'b1111 ) ? ST_B : next;
end

always_comb begin
	unique case (current)
		ST_IDLE: ctrl = '{mode:b'0000, next:ST_IDLE};
		ST_L1:	 ctrl = '{mode:b'0001, next:ST_L2};
		ST_L2:	 ctrl = '{mode:b'0001, next:ST_L3};
		ST_L3:   ctrl = '{mode:b'0001, next:ST_IDLE};
		ST_R1:   ctrl = '{mode:b'0010, next:ST_R2};
		ST_R2:   ctrl = '{mode:b'0010, next:ST_R3};
		ST_R3:   ctrl = '{mode:b'0010, next:ST_IDLE};
		ST_H1:   ctrl = '{mode:b'0100, next:ST_H2};
		ST_H2:   ctrl = '{mode:b'0100, next:ST_H3};
		ST_H3:   ctrl = '{mode:b'0100, next:ST_IDLE};
		ST_B:    ctrl = '{mode:b'1111, next:ST_B};
	endcase
end

assign out = current;

endmodule
