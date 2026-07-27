`timescale 1ns / 1ps
`include "top.v"

module top_tb;

    reg clk;
    reg reset;
    wire [31:0] current_instruction;

    top dut (
        .clk(clk),
        .reset(reset),
        .current_instruction(current_instruction)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);

        // Initialize input. Hold on reset.
        clk = 0;
        reset = 1;

        // Wait 12 ns
        #12;

        // Release reset
        reset = 0;

        // Let CPU run for 200 ns (20 clock cycles)
        #200;

        // End simulation
        $finish;
    end

endmodule
