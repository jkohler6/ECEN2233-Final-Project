`timescale 1ns/1ps

module tb_tbird_fsm;

    logic       clk, rst;
    logic [3:0] in;
    logic [5:0] out;

    tbird_fsm dut (.*);

    localparam CLK_P = 10;
    initial clk = 0;
    always #(CLK_P/2) clk = ~clk;

    task automatic pulse_rst;
        rst = 1; @(posedge clk); #1;
        rst = 0; @(posedge clk); #1;
    endtask

    task automatic drive(input logic [3:0] stim, input int cycles);
        in = stim;
        repeat (cycles) @(posedge clk);
        #1;
    endtask

    task automatic check(input logic [5:0] exp, input string tag);
        if (out !== exp)
            $error("[%0t] %s  EXP=%06b  GOT=%06b", $time, tag, exp, out);
        else
            $display("[%0t] %s  OK  (%06b)", $time, tag, out);
    endtask

    localparam logic [5:0] IDLE = 6'b000000,
                           L1   = 6'b001000,
                           L2   = 6'b011000,
                           L3   = 6'b111000,
                           R1   = 6'b000100,
                           R2   = 6'b000110,
                           R3   = 6'b000111,
                           H1   = 6'b001100,
                           H2   = 6'b011110,
                           ALL  = 6'b111111;

    initial begin
        $display("=== tbird_fsm testbench ===");
        in = 0;

        pulse_rst;
        check(IDLE, "RST->IDLE");

        drive(4'b0001, 1); check(L1, "LEFT L1");
        drive(4'b0000, 1); check(L2, "LEFT L2");
        drive(4'b0000, 1); check(L3, "LEFT L3");
        drive(4'b0000, 1); check(IDLE, "LEFT->IDLE");

        drive(4'b0010, 1); check(R1, "RIGHT R1");
        drive(4'b0000, 1); check(R2, "RIGHT R2");
        drive(4'b0000, 1); check(R3, "RIGHT R3");
        drive(4'b0000, 1); check(IDLE, "RIGHT->IDLE");

        drive(4'b0100, 1); check(H1, "HAZ H1");
        drive(4'b0000, 1); check(H2, "HAZ H2");
        drive(4'b0000, 1); check(ALL, "HAZ ALL");
        drive(4'b0000, 1); check(IDLE, "HAZ->IDLE");

        drive(4'b1000, 1); check(ALL, "ALLON from IDLE");
        drive(4'b0000, 1); check(IDLE, "ALLON->IDLE");

        drive(4'b0001, 1); check(L1, "PRI: start left");
        drive(4'b1000, 1); check(ALL, "PRI: in[3] overrides");
        drive(4'b0000, 1); check(IDLE, "PRI: back to IDLE");

        drive(4'b0010, 1); check(R1, "PRI: start right");
        drive(4'b0100, 1); check(H1, "PRI: hazard overrides");
        drive(4'b0000, 1); check(H2, "PRI: H2");
        drive(4'b0000, 1); check(ALL, "PRI: ALL");
        drive(4'b0000, 1); check(IDLE, "PRI: ->IDLE");

        drive(4'b0001, 1); check(L1, "ARST: start left");
        pulse_rst;
        check(IDLE, "ARST: reset mid-seq");


        $display("=== done ===");
        $finish;
    end

endmodule
