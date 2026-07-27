`include "../Program Counter/pc.v"
`include "../Instruction Memory/imem.v"

module top (
    input wire clk,
    input wire reset,
    output wire [31:0] current_instruction
);

    wire [31:0] pc_in;
    wire [31:0] pc_out;

    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    imem imem_inst (
        .mem_add(pc_out),
        .mem_inst(current_instruction)
    );

    assign pc_in = pc_out + 32'd4;

endmodule
