`timescale 1ns / 1ps

module tb_instruction_fetch;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [31:0] pc;
    wire [31:0] instruction;

    // DUT Instantiation
    instruction_fetch uut (
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .instruction(instruction)
    );

    // Clock Generation
    always #5 clk = ~clk;

    // Test Sequence
    initial begin

        // Initial Conditions
        clk = 0;
        rst = 1;

        // Hold reset for 20 ns
        #20;
        rst = 0;

        // Run simulation for 100 ns
        #100;

        $finish;

    end

endmodule
