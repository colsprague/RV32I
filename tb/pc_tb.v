`timescale 1ns / 1ps
`include "pc.v"

module pc_tb;

    reg clk;
    reg reset;
    reg [31:0] pc_in;
    wire [31:0] pc_out;

    pc uut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("pc_sim.vcd");
        $dumpvars(0, pc_tb);

        clk = 0;
        reset = 1;
        pc_in = 32'h0;

        #12;
        reset = 0;

        pc_in = 32'h0000_0004;
        #10;

        pc_in = 32'h0000_0008;
        #10;

        pc_in = 32'h0000_000C;
        #10;

        reset = 1;
        #10;

        $finish;
    end

endmodule
