module alu_mux(
    input  [31:0] read_data2,
    input  [31:0] immediate,
    input         ALUSrc,
    output [31:0] alu_input_B
);

    assign alu_input_B = ALUSrc ? immediate : read_data2;

endmodule