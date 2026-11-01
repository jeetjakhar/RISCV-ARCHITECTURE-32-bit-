`timescale 1ns / 1ps

module tb_pc;

reg clk;
reg rst;

wire [31:0] pc;

program_counter uut (
    .clk(clk),
    .rst(rst),
    .pc(pc)
);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    #20;

    rst = 0;

    #100;

    $finish;

end

endmodule