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
	input logic rst,
	input logic left,
	input logic right,
    input logic brake,
	output logic [3:0] state
);

logic [3:0] nextstate,

// dffarray will store the current state
    dffarray #(.WIDTH(4)) state_reg (
        .clk   (clk),
        .rst (rst),
        .d_in  (nextstate),         // Input from Next State Logic
        .q_out (state)   // Output to Combinational Logic
    );

// DEFINE STATES!!!
typedef enum logic [3:0] {
    IDLE   = 4'b0000,
    BRAKE  = 4'b0001,
    H1     = 4'b0010,
    H2     = 4'b0011,
    H3     = 4'b0100,
	R1     = 4'b0101,
	R2     = 4'b0110,
	R3     = 4'b0111,
	L1     = 4'b1000,
	L2     = 4'b1001,
	L3     = 4'b1010,
} thunderbird_state_t;

thunderbird_state_t current_state, next_state;


// LOGIC GOES HERE!!!
always_comb begin : fsm

	// Make it RESET
	if(rst){nextstate = IDLE;}

	// Make it BRAKE
	else if(brake){nextstate = BRAKE;}
	
	// Make it H2 if already at H1
	else if(state == H1){nextstate = H2;}

	// Make it H3 if already at H2
	else if(state == H2){nextstate = H3;}

	// Go to H1 if left and right are pressed. Brake and H states were already checked above
	else if(left && right){nextstate = H1;}

	// rst, brake, and hazards have already been checked. Move on to turn signals

	// CONTINUE LEFT!
	else if(state == L1){nextstate = L2;}

	// CONTINUE LEFT, AGAIN!
	else if(state == L2){nextstate = L3;}

	// CONTINUE RIGHT!
	else if(state == R1){nextstate = R2;}

	// CONTINUE RIGHT, AGAIN!
	else if(state == R2){nextstate = R3;}

	// LOOPING CHECKS ARE DONE, CHECK FOR MOVING FROM IDLE OR TO LOWER STATES!

	// BEGIN LEFT!
	else if(left){nextstate = L1;}

	// BEGIN RIGHT!
	else if(left){nextstate = R1;}

	// IF ALL ELSE FAILS, BECOME IDLE!
	else {nextstate = IDLE;}

end


endmodule