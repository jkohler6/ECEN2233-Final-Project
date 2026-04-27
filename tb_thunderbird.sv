`timescale 1ns/1ps

module tb_thunderbird;
    logic       clk;
    logic [3:0] btn;
    logic [7:0] led;
    logic [7:0] ssegout;
    logic [3:0] an;

    top uut (
        .sysclk_125mhz(clk),
        .btn(btn),
        .led(led[5:0]),
        .ssegout(ssegout[7:0])
    );

    localparam logic [3:0] MODE_IDLE   = 4'd0;
    localparam logic [3:0] MODE_LEFT   = 4'd1;
    localparam logic [3:0] MODE_RIGHT  = 4'd2;
    localparam logic [3:0] MODE_HAZARD = 4'd3;
    localparam logic [3:0] MODE_BRAKE  = 4'd4;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    task automatic wait_step;
        begin
            @(posedge uut.divd_clk); 
            #1;
        end
    endtask

    task automatic check_outputs(
        input logic [5:0] exp_lights,
        input logic [3:0] exp_mode,
        input string       label
    );
        begin
            if (uut.led !== exp_lights || uut.fsm.out !== exp_mode) begin
                $error("%s FAILED: lights=%b expected=%b state=%d expected=%d time=%0t",
                       label, uut.led, exp_lights, uut.fsm.out, exp_mode, $time);
                $fatal;
            end else begin
                $display("%s OK: lights=%b state=%d time=%0t",
                         label, uut.led, uut.fsm.out, $time);
            end
        end
    endtask

initial begin
    btn = 4'b0010;
    repeat (200) @(posedge clk);
        #1;
        check_outputs(6'b000000, MODE_IDLE, "Reset/Idle");

        btn[1] = 1'b0;

        // LEFT = btn[3]
        btn[3] = 1'b1;
        wait_step; check_outputs(6'b001000, MODE_LEFT, "Left step 1");
        btn[3] = 1'b0;
        wait_step; check_outputs(6'b011000, MODE_LEFT, "Left step 2 after release");
        wait_step; check_outputs(6'b111000, MODE_LEFT, "Left step 3 after release");
        wait_step; check_outputs(6'b000000, MODE_IDLE, "Back to idle after left completes");

        // RIGHT = btn[0]
        btn[0] = 1'b1;
        wait_step; check_outputs(6'b000100, MODE_RIGHT, "Right step 1");
        wait_step; check_outputs(6'b000110, MODE_RIGHT, "Right step 2");
        wait_step; check_outputs(6'b000111, MODE_RIGHT, "Right step 3");
        wait_step; check_outputs(6'b000100, MODE_RIGHT, "Right repeats while held");
        btn[0] = 1'b0;
        wait_step; check_outputs(6'b000110, MODE_RIGHT, "Right continues after release");
        wait_step; check_outputs(6'b000111, MODE_RIGHT, "Right final step after release");
        wait_step; check_outputs(6'b000000, MODE_IDLE, "Back to idle after right completes");

        // HAZARD = btn[3] + btn[0]
        btn[3] = 1'b1;
        btn[0] = 1'b1;
        wait_step; check_outputs(6'b001100, MODE_HAZARD, "Hazard step 1");
        btn[3] = 1'b0;
        btn[0] = 1'b0;
        wait_step; check_outputs(6'b011110, MODE_HAZARD, "Hazard step 2 after release");
        wait_step; check_outputs(6'b111111, MODE_HAZARD, "Hazard step 3 after release");
        wait_step; check_outputs(6'b000000, MODE_IDLE, "Back to idle after hazard completes");

        // BRAKE = btn[2]
        btn[3] = 1'b1;
        btn[2] = 1'b1;
        wait_step; check_outputs(6'b111111, MODE_BRAKE, "Brake overrides left");
        btn[3] = 1'b0;
        btn[0] = 1'b1;
        wait_step; check_outputs(6'b111111, MODE_BRAKE, "Brake still overrides right");
        btn[2] = 1'b0;
        wait_step; check_outputs(6'b000100, MODE_RIGHT, "Right starts after brake release");
        btn[0] = 1'b0;
        wait_step; check_outputs(6'b000110, MODE_RIGHT, "Right completes after release");
        wait_step; check_outputs(6'b000111, MODE_RIGHT, "Right final after release");
        wait_step; check_outputs(6'b000000, MODE_IDLE, "Final idle");

        $display("All thunderbird FSM checks passed.");
        $finish;
    end
endmodule
