module thunderbird_fsm (
    input  logic       clk,
    input  logic       reset,
    input  logic       step_en,
    input  logic       left,
    input  logic       right,
    input  logic       brake,
    output logic [5:0] lights,
    output logic [3:0] mode
);
    // lights[5:3] = left side LEDs  (shown left-to-right on board)
    // lights[2:0] = right side LEDs (shown left-to-right on board)
    // Left turn starts from the RIGHT-MOST LED of the left cluster:
    //   001 -> 011 -> 111
    // Right turn starts from the LEFT-MOST LED of the right cluster:
    //   100 -> 110 -> 111

    localparam logic [3:0] MODE_IDLE   = 4'd0;
    localparam logic [3:0] MODE_LEFT   = 4'd1;
    localparam logic [3:0] MODE_RIGHT  = 4'd2;
    localparam logic [3:0] MODE_HAZARD = 4'd3;
    localparam logic [3:0] MODE_BRAKE  = 4'd4;

    typedef enum logic [3:0] {
        IDLE_ST,
        LEFT1_ST,
        LEFT2_ST,
        LEFT3_ST,
        RIGHT1_ST,
        RIGHT2_ST,
        RIGHT3_ST,
        HAZ1_ST,
        HAZ2_ST,
        HAZ3_ST,
        BRAKE_ST
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE_ST;
        else if (step_en)
            current_state <= next_state;
    end

    always_comb begin
        next_state = current_state;

        unique case (current_state)
            IDLE_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else if (left && right)
                    next_state = HAZ1_ST;
                else if (left)
                    next_state = LEFT1_ST;
                else if (right)
                    next_state = RIGHT1_ST;
                else
                    next_state = IDLE_ST;
            end

            LEFT1_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else if (left && right)
                    next_state = HAZ1_ST;
                else
                    next_state = LEFT2_ST;
            end

            LEFT2_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else if (left && right)
                    next_state = HAZ1_ST;
                else
                    next_state = LEFT3_ST;
            end

            LEFT3_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else if (left && right)
                    next_state = HAZ1_ST;
                else if (left)
                    next_state = LEFT1_ST;
                else if (right)
                    next_state = RIGHT1_ST;
                else
                    next_state = IDLE_ST;
            end

            RIGHT1_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else if (left && right)
                    next_state = HAZ1_ST;
                else
                    next_state = RIGHT2_ST;
            end

            RIGHT2_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else if (left && right)
                    next_state = HAZ1_ST;
                else
                    next_state = RIGHT3_ST;
            end

            RIGHT3_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else if (left && right)
                    next_state = HAZ1_ST;
                else if (right)
                    next_state = RIGHT1_ST;
                else if (left)
                    next_state = LEFT1_ST;
                else
                    next_state = IDLE_ST;
            end

            HAZ1_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else
                    next_state = HAZ2_ST;
            end

            HAZ2_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else
                    next_state = HAZ3_ST;
            end

            HAZ3_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else if (left && right)
                    next_state = HAZ1_ST;
                else if (left)
                    next_state = LEFT1_ST;
                else if (right)
                    next_state = RIGHT1_ST;
                else
                    next_state = IDLE_ST;
            end

            BRAKE_ST: begin
                if (brake)
                    next_state = BRAKE_ST;
                else if (left && right)
                    next_state = HAZ1_ST;
                else if (left)
                    next_state = LEFT1_ST;
                else if (right)
                    next_state = RIGHT1_ST;
                else
                    next_state = IDLE_ST;
            end

            default: next_state = IDLE_ST;
        endcase
    end

    always_comb begin
        lights = 6'b000000;
        mode   = MODE_IDLE;

        unique case (current_state)
            IDLE_ST: begin
                lights = 6'b000000;
                mode   = MODE_IDLE;
            end

            LEFT1_ST: begin
                lights = 6'b001000;
                mode   = MODE_LEFT;
            end
            LEFT2_ST: begin
                lights = 6'b011000;
                mode   = MODE_LEFT;
            end
            LEFT3_ST: begin
                lights = 6'b111000;
                mode   = MODE_LEFT;
            end

            RIGHT1_ST: begin
                lights = 6'b000100;
                mode   = MODE_RIGHT;
            end
            RIGHT2_ST: begin
                lights = 6'b000110;
                mode   = MODE_RIGHT;
            end
            RIGHT3_ST: begin
                lights = 6'b000111;
                mode   = MODE_RIGHT;
            end

            HAZ1_ST: begin
                lights = 6'b001100;
                mode   = MODE_HAZARD;
            end
            HAZ2_ST: begin
                lights = 6'b011110;
                mode   = MODE_HAZARD;
            end
            HAZ3_ST: begin
                lights = 6'b111111;
                mode   = MODE_HAZARD;
            end

            BRAKE_ST: begin
                lights = 6'b111111;
                mode   = MODE_BRAKE;
            end

            default: begin
                lights = 6'b000000;
                mode   = MODE_IDLE;
            end
        endcase
    end
endmodule
