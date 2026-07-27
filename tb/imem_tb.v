`timescale 1ns / 1ps
`include "imem.v"


module imem_tb;

    reg  [31:0] mem_add;
    wire [31:0] mem_inst;

    imem uut (
        .mem_add(mem_add),
        .mem_inst(mem_inst)
    );

    initial begin
        $dumpfile("imem_tb.vcd");
        $dumpvars(0, imem_tb);

        mem_add = 32'h00000000; #10;
        mem_add = 32'h00000004; #10;
        mem_add = 32'h00000008; #10;
        mem_add = 32'h0000000C; #10;

        $finish;
    end

endmodule
