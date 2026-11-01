`timescale 1ns / 1ps

module instruction_fetch(

    input clk,
    input rst,

    output [31:0] pc,
    output [31:0] instruction

);

wire [31:0] int_pc;

//-------------------------
// Program Counter
//-------------------------

program_counter pc_inst(

    .clk(clk),
    .rst(rst),
    .pc(int_pc)

);

//-------------------------
// Instruction Memory
//-------------------------

instruction_memory imem_inst(
    .pc(int_pc),
    .instruction(instruction)
);

//-------------------------
// Output Connection
//-------------------------

assign pc = int_pc;

endmodule