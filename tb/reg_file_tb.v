`timescale 1ns / 1ps
`include "reg_file.v"

module reg_file_tb;
    // Signals
    reg clk;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;
    reg WE3;

    wire [31:0] RD1, RD2;

    // Instantiation
    reg_file uut (
        .clk(clk),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .WE3(WE3),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        // Output
        $dumpfile("reg_file_tb.vcd");
        $dumpvars(0, reg_file_tb);

        // Initialize inputs
        clk = 0;
        A1 = 0;
        A2 = 0;
        A3 = 0;
        WD3 = 0;
        WE3 = 0;

        #12;

        // T1: Read register 0 (RD1 and RD2 should be 0)
        A1 = 5'b0;
        A2 = 5'b0;
        #10;

        // T2: Write to register 0 (Should be ignored, RD1 and RD2 should be 0)
        A3 = 5'b0;
        WD3 = 32'hFFFFFFFF;
        WE3 = 1'b1;
        #10;
        WE3 = 1'b0;
        #5;

        // T3: Write to reg 1 and reg 2
        A1 = 5'b01;
        A2 = 5'b10;
        A3 = 5'b1;
        WD3 = 32'h11111111;
        WE3 = 1'b1;
        #10;

        A3 = 5'b10;
        WD3 = 32'h22222222;
        WE3 = 1'b1;
        #10;

        WE3 = 1'b0;

        // T4: Read reg 1 and reg 2 simultaneously
        A1 = 5'b01;
        A2 = 5'b10;
        #10;

        // T5: Verify WE3 = 0 prevents writing
        A3 = 5'b1;
        WD3 = 32'hFFFFFFFF;
        WE3 = 1'b0;
        #10;

        A1 = 5'b1;
        #5;

        // T6: Ensure reading is instantaneous
        A1 = 5'd0;
        A2 = 5'd0;
        #3
        A1 = 5'd1;
        A2 = 5'd2;
        #3
        A1 = 5'd0;
        A2 = 5'd0;
        #10;

        $finish;
    end
endmodule
