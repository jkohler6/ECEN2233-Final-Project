/*
Modes

Reset Mode:
All lights OFF
FSM goes to IDLE

Left Turn
Left lights flash
Continues even if button is released

Right turn
same as left turn

Hazard Mode:
Right and left stuck together
Activates if L and R are both pressed

Brake Mode:
All lights ON
Lights stay ON while brake is active

Priority:
Brake > Hazard > Turn Signals (Left/Right)
*/

module fsm (
	input logic clk,
	input logic rst,
	input logic preempt,
	input logic [3:0] ctrl,
	output logic [5:0] out,
	output logic [3:0] mode
);

typedef struct packed {
	logic	brake,
	logic   L,
	logic	R,
	logic	H
} ctrl_t;

typedef enum logic [5:0] {
	ST_IDLE = 3'b000000,
	ST_L1   = 3'b001000,
	ST_L2	= 3'b011000,
	ST_L3   = 3'b111000,
	ST_R1	= 3'b000100,
	ST_R2	= 3'b000110,
	ST_R3	= 3'b000111,
	H1_ST	= 3'b001100,
	H2_ST	= 3'b011110,
	H3_ST	= 3'b111111,
	B_ST	= 3'b111111
} state_t;

state_t current, next;
ctrl_t ctrl;

always_comb begin
	unique case (current)
		ST_IDLE: ctrl = '{};
		ST_L1:	 ctrl = '{next:ST_L2};
		ST_L2:	 ctrl = '{next:ST_L3};
		ST_L3:   ctrl = '{next:ST_IDLE};
		ST_R1:   ctrl = '{next:ST_R2};
		ST_R2:   ctrl = '{next:ST_R3};
		ST_R3:   ctrl = '{next:ST_IDLE};
		H1_ST:   ctrl = '{next:ST_H2};
		H2_ST:   ctrl = '{next:ST_H3};
		H3_ST:   ctrl = '{next:ST_IDLE};
		B_ST:    ctrl = '{next:ST_B};
	endcase
end

assign next = state_t'(ctrl.next);

always_ff @(posedge clk or posedge rst) begin
	if (reset)
		current <= ST_IDLE;
	else
		current <= preempt ? B_ST : next;
end

assign out = current;

endmodule
