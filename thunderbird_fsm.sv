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
	// *removed until we need it again, if something breaks because rst is missing, uncomment this line
	input logic clk,
	input logic rst,
	input logic en,
	input logic left,
	input logic right,
    	input logic brake,
	output logic [5:0] lights,
	output logic [3:0] mode
);

typedef enum logic [3:0] {
	ST_IDLE,
	ST_L1,
	ST_L2,
	ST_L3,
	ST_R1,
	ST_R2,
	ST_R3,
	H1_ST,
	H2_ST,
	H3_ST,
	B_ST
}state_t;

state_t current, next;

always_ff @(posedge clk or posedge rst) begin
	if(reset)
		current <= ST_IDLE;
	else if (en)
		current <= next;
end

always_comb begin
	next = current;

	unique case (current)
endmodule
