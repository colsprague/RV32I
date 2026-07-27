module imem(
    input wire [31:0] mem_add,
    output wire [31:0] mem_inst
);
    // 63 data of 32 bits
    reg [31:0] RAM [0:63];

    initial begin
        $readmemh("instructions.hex", RAM);
    end

    // Map each memory address (incremented by 4) to RAM index (incremented by 1) by accessing RAM[mem_add / 4]
    assign mem_inst = RAM[mem_add[31:2]];

endmodule
