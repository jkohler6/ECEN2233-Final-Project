module tbird_fsm (
	input logic clk,
	input logic rst,
	input logic [3:0] in,
	output logic [5:0] out
);

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
	ST_A  = 6'b111111
} state_t;

state_t current, next;

always_ff @(posedge clk or posedge rst) begin
	if (rst)
		current <= ST_IDLE;
	else
		current <= next;
end

always_comb begin
	unique case (current)
		ST_IDLE: begin
			case (in)
				4'b0001: next = ST_L1;
				4'b0010: next = ST_R1;
				4'b0100: next = ST_A;
				default: next = ST_IDLE;
			endcase
		end
        ST_L1:   next = ST_L2;
        ST_L2:   next = ST_L3;
        ST_L3:   next = ST_IDLE;
        ST_R1:   next = ST_R2;
        ST_R2:   next = ST_R3;
        ST_R3:   next = ST_IDLE;
        ST_H1:   next = ST_H2;
        ST_H2:   next = ST_A;
        ST_A:    next = (in == 4'b1111) ? ST_A : ST_IDLE;
        default: next = ST_IDLE;
	endcase
end

assign out = current;

endmodule