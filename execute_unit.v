module execute_unit(
    input  [31:0] read_data1,
    input  [31:0] read_data2,
    input  [31:0] immediate,

    input         ALUSrc,
    input  [2:0]  ALUOp,

    output [31:0] ALU_result
);

    wire [31:0] alu_input_B;


    // ALU input MUX
    alu_mux mux1 (
        .read_data2(read_data2),
        .immediate(immediate),
        .ALUSrc(ALUSrc),
        .alu_input_B(alu_input_B)
    );


    // ALU
    alu alu1 (
        .A(read_data1),
        .B(alu_input_B),
        .aluop(ALUOp),
        .result(ALU_result)
    );

endmodule