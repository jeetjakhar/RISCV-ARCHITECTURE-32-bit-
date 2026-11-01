module tb_alu_control;

    reg [1:0] ALUOp;
    reg [2:0] funct3;
    reg [6:0] funct7;

    wire [2:0] aluop;

    alu_control DUT (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .aluop(aluop)
    );

    initial begin

        // ==========================================
        // TEST 1: LOAD / STORE
        // Expected: ADD
        // ==========================================

        ALUOp = 2'b00;
        funct3 = 3'b000;
        funct7 = 7'b0000000;

        #10;

        $display("--------------------------------");
        $display("TEST 1: LOAD / STORE");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 2: BRANCH
        // Expected: SUB
        // ==========================================

        ALUOp = 2'b01;

        #10;

        $display("--------------------------------");
        $display("TEST 2: BRANCH");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 3: R-TYPE ADD
        // funct3 = 000
        // funct7 = 0000000
        // ==========================================

        ALUOp = 2'b10;
        funct3 = 3'b000;
        funct7 = 7'b0000000;

        #10;

        $display("--------------------------------");
        $display("TEST 3: R-TYPE ADD");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 4: R-TYPE SUB
        // funct3 = 000
        // funct7 = 0100000
        // ==========================================

        funct7 = 7'b0100000;

        #10;

        $display("--------------------------------");
        $display("TEST 4: R-TYPE SUB");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 5: R-TYPE AND
        // ==========================================

        funct3 = 3'b111;
        funct7 = 7'b0000000;

        #10;

        $display("--------------------------------");
        $display("TEST 5: R-TYPE AND");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 6: R-TYPE OR
        // ==========================================

        funct3 = 3'b110;

        #10;

        $display("--------------------------------");
        $display("TEST 6: R-TYPE OR");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 7: R-TYPE XOR
        // ==========================================

        funct3 = 3'b100;

        #10;

        $display("--------------------------------");
        $display("TEST 7: R-TYPE XOR");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 8: R-TYPE SLT
        // ==========================================

        funct3 = 3'b010;

        #10;

        $display("--------------------------------");
        $display("TEST 8: R-TYPE SLT");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 9: ADDI
        // ==========================================

        ALUOp = 2'b11;
        funct3 = 3'b000;

        #10;

        $display("--------------------------------");
        $display("TEST 9: ADDI");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 10: ANDI
        // ==========================================

        funct3 = 3'b111;

        #10;

        $display("--------------------------------");
        $display("TEST 10: ANDI");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 11: ORI
        // ==========================================

        funct3 = 3'b110;

        #10;

        $display("--------------------------------");
        $display("TEST 11: ORI");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 12: XORI
        // ==========================================

        funct3 = 3'b100;

        #10;

        $display("--------------------------------");
        $display("TEST 12: XORI");
        $display("ALU Operation = %b", aluop);


        // ==========================================
        // TEST 13: SLTI
        // ==========================================

        funct3 = 3'b010;

        #10;

        $display("--------------------------------");
        $display("TEST 13: SLTI");
        $display("ALU Operation = %b", aluop);


        #10;

        $finish;

    end

endmodule