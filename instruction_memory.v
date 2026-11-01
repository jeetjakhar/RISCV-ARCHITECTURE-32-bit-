`timescale 1ns / 1ps

module instruction_memory(
    input  [31:0] pc,
    output reg [31:0] instruction
);

    // 256 locations, each storing one 32-bit instruction
    reg [31:0] memory [0:255];

    // Initialize memory
    initial begin
        memory[0] = 32'h002081B3; // add x3, x1, x2
        memory[1] = 32'h40310233; // sub x4, x2, x3
        memory[2] = 32'h0020F2B3; // and x5, x1, x2
        memory[3] = 32'h0020E333; // or  x6, x1, x2
    end

    // Combinational read
    always @(*) begin
        instruction = memory[pc[31:2]];
    end

endmodule