module reg_file (
    input wire clk,
    input wire [4:0] A1, A2, A3,
    input wire [31:0] WD3,
    input wire WE3,

    output wire [31:0] RD1, RD2
);
    reg [31:0] registers [0:31];

    assign RD1 = (A1 == 0) ? 0 : registers[A1];
    assign RD2 = (A2 == 0) ? 0 : registers[A2];

    always @(posedge clk) begin
        
        if (WE3 == 1'b1 && A3 != 0) begin
            registers[A3] <= WD3;
        end
    end
endmodule
