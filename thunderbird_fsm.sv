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
}state_t;

state_t current, next;

always_ff @(posedge clk or posedge rst) begin
	if (brake)
		current <= B_ST;
	else if (reset)
		current <= ST_IDLE;
	else if (en)
		current <= next;
end

always_comb begin
	next = current;

	unique case (current) {

endmodule
