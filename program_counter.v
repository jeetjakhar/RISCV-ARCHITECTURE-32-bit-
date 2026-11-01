`timescale 1ns / 1ps
module program_counter (
    input clk,
    input rst,
    output reg [31:0] pc
);

always @(posedge clk) begin
    if (rst)
        pc <= 32'd0;
    else
        pc <= pc + 32'd4;
end

endmodule
