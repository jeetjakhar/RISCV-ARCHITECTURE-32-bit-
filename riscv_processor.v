`timescale 1ns / 1ps

module riscv_processor(
    input clk,
    input rst
);

    // =========================================================
    // 1. PROGRAM COUNTER
    // =========================================================

    wire [31:0] pc;


    program_counter pc1 (
        .clk(clk),
        .rst(rst),
        .pc(pc)
    );


    // =========================================================
    // 2. INSTRUCTION MEMORY
    // =========================================================

    wire [31:0] instruction;


    instruction_memory imem (
        .pc(pc),
        .instruction(instruction)
    );


    // =========================================================
    // 3. INSTRUCTION DECODER
    // =========================================================

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;


    instruction_decoder decoder (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .funct3(funct3),
        .funct7(funct7)
    );


    // =========================================================
    // 4. CONTROL UNIT
    // =========================================================

    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire Branch;
    wire Jump;
    wire ALUSrc;
    wire [1:0] ALUOp;


    control_unit cu (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .Jump(Jump),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)
    );


    // =========================================================
    // 5. REGISTER FILE
    // =========================================================

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    wire [31:0] write_data;


        register_file rf (
        .clk(clk),
        .RegWrite(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );


    // =========================================================
    // 6. IMMEDIATE GENERATOR
    // =========================================================

    wire [31:0] immediate;


    wire [31:0] immediate;

    assign imm_type =
        (opcode == 7'b0000011) ? 3'b001 :   // LW - I-Type
        (opcode == 7'b0010011) ? 3'b001 :   // ADDI/ANDI/ORI/XORI/SLTI - I-Type
        (opcode == 7'b0100011) ? 3'b010 :   // SW - S-Type
        (opcode == 7'b1100011) ? 3'b011 :   // Branch - B-Type
        (opcode == 7'b1101111) ? 3'b100 :   // JAL - J-Type
        3'b000;                               // Default
    
    imm_gen imm_generator (
        .instruction(instruction),
        .imm_type(imm_type),
        .immediate(immediate)
    );
    
    // =========================================================
    // 7. ALU CONTROL
    // =========================================================

    wire [2:0] aluop;


    alu_control alu_ctrl (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .aluop(aluop)
    );


    // =========================================================
    // 8. ALU INPUT MUX
    // =========================================================

    wire [31:0] alu_input_B;


    alu_mux mux1 (
        .read_data2(read_data2),
        .immediate(immediate),
        .ALUSrc(ALUSrc),
        .alu_input_B(alu_input_B)
    );


    // =========================================================
    // 9. ALU
    // =========================================================

    wire [31:0] ALU_result;


    alu alu1 (
        .A(read_data1),
        .B(alu_input_B),
        .aluop(aluop),
        .result(ALU_result)
    );


    // =========================================================
    // 10. DATA MEMORY
    // =========================================================

    wire [31:0] memory_read_data;


    data_memory data_mem (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .address(ALU_result),
        .write_data(read_data2),
        .read_data(memory_read_data)
    );


    // =========================================================
    // 11. WRITE-BACK MUX
    // =========================================================

    writeback_mux wb_mux (
        .alu_result(ALU_result),
        .read_data(memory_read_data),
        .MemToReg(MemRead),
        .write_data(write_data)
    );


endmodule