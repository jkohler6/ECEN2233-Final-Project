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
	// *removed until we need it again, if something breaks because rst is missing, uncomment this line
	// input logic rst,
	input logic left,
	input logic right,
    input logic brake,
	input logic [3:0] prev,
	output logic [3:0] state
);



endmodule