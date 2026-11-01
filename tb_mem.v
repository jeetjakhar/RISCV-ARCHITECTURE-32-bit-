`timescale 1ns / 1ps

module tb_mem;

reg  [31:0] pc;
wire [31:0] instruction;

instruction_mem uut (
    .pc(pc),
    .instruction(instruction)
);

initial begin
    pc = 0;
    #10;

    pc = 4;
    #10;

    pc = 8;
    #10;

    pc = 12;
    #10;

    $finish;
end

endmodule

