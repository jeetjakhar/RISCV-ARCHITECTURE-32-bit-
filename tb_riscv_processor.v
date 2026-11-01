`timescale 1ns / 1ps

module tb_riscv_processor;

    reg clk;
    reg rst;

    riscv_processor DUT (
        .clk(clk),
        .rst(rst)
    );

    // 10 ns clock
    always #5 clk = ~clk;


    initial begin

        clk = 0;
        rst = 1;


        // ==========================================
        // INITIAL REGISTER VALUES
        // ==========================================

        DUT.rf.registers[1] = 32'd10;
        DUT.rf.registers[2] = 32'd32;


        // ==========================================
        // INSTRUCTION 1
        // ADD x3, x1, x2
        // ==========================================

        DUT.imem.memory[0] = 32'h002081B3;


        // ==========================================
        // INSTRUCTION 2
        // SUB x4, x2, x1
        // ==========================================

        DUT.imem.memory[1] = 32'h40110233;


        // ==========================================
        // INSTRUCTION 3
        // AND x5, x1, x2
        // ==========================================

        DUT.imem.memory[2] = 32'h0020F2B3;


        // ==========================================
        // INSTRUCTION 4
        // OR x6, x1, x2
        // ==========================================

        DUT.imem.memory[3] = 32'h0020E333;


        // ==========================================
        // INSTRUCTION 5
        // XOR x7, x1, x2
        // ==========================================

        DUT.imem.memory[4] = 32'h0020C3B3;


        // ==========================================
        // INSTRUCTION 6
        // ADDI x8, x1, 5
        // ==========================================

        DUT.imem.memory[5] = 32'h00508413;


        // ==========================================
        // RELEASE RESET
        // ==========================================

        #20;

        rst = 0;


        // ==========================================
        // WAIT UNTIL ADDI IS CURRENT INSTRUCTION
        //
        // At 25 ns -> ADD
        // At 35 ns -> SUB
        // At 45 ns -> AND
        // At 55 ns -> OR
        // At 65 ns -> XOR
        // At 75 ns -> ADDI
        //
        // Wait until 80 ns so ADDI has executed.
        // ==========================================

        #60;


        // ==========================================
        // DISPLAY RESULTS
        // ==========================================

        $display("--------------------------------");
        $display("RISC-V MULTI-INSTRUCTION TEST");
        $display("--------------------------------");

        $display("x1 = %d", DUT.rf.registers[1]);
        $display("x2 = %d", DUT.rf.registers[2]);

        $display("x3 = %d  (ADD)", DUT.rf.registers[3]);
        $display("x4 = %d  (SUB)", DUT.rf.registers[4]);
        $display("x5 = %d  (AND)", DUT.rf.registers[5]);
        $display("x6 = %d  (OR)",  DUT.rf.registers[6]);
        $display("x7 = %d  (XOR)", DUT.rf.registers[7]);
        $display("x8 = %d  (ADDI)", DUT.rf.registers[8]);

        $display("PC = %d", DUT.pc);

        $display("--------------------------------");


        // ==========================================
        // CHECK RESULTS
        // ==========================================

        if (DUT.rf.registers[3] == 32'd42)
            $display("ADD  : PASS");
        else
            $display("ADD  : FAIL");


        if (DUT.rf.registers[4] == 32'd22)
            $display("SUB  : PASS");
        else
            $display("SUB  : FAIL");


        if (DUT.rf.registers[5] == 32'd0)
            $display("AND  : PASS");
        else
            $display("AND  : FAIL");


        if (DUT.rf.registers[6] == 32'd42)
            $display("OR   : PASS");
        else
            $display("OR   : FAIL");


        if (DUT.rf.registers[7] == 32'd42)
            $display("XOR  : PASS");
        else
            $display("XOR  : FAIL");


        if (DUT.rf.registers[8] == 32'd15)
            $display("ADDI : PASS");
        else
            $display("ADDI : FAIL");


        // ==========================================
        // ADDI DEBUG
        // ==========================================

        $display("--------------------------------");
        $display("ADDI DEBUG");
        $display("--------------------------------");

        $display("Instruction = %h", DUT.instruction);
        $display("Opcode      = %b", DUT.opcode);

        $display("rs1         = %d", DUT.rs1);
        $display("rd          = %d", DUT.rd);
        $display("funct3      = %b", DUT.funct3);
        $display("funct7      = %b", DUT.funct7);

        $display("RegWrite    = %b", DUT.RegWrite);
        $display("ALUSrc      = %b", DUT.ALUSrc);
        $display("ALUOp       = %b", DUT.ALUOp);

        $display("imm_type    = %b", DUT.imm_type);
        $display("Immediate   = %d", DUT.immediate);

        $display("Read Data 1 = %d", DUT.read_data1);
        $display("Read Data 2 = %d", DUT.read_data2);

        $display("ALU Input B = %d", DUT.alu_input_B);
        $display("ALU Result  = %d", DUT.ALU_result);

        $display("x8          = %d", DUT.rf.registers[8]);

        $display("--------------------------------");


        #10;

        $finish;

    end

endmodule