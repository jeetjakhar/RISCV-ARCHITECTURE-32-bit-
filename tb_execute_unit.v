module tb_execute_unit;

    reg  [31:0] read_data1;
    reg  [31:0] read_data2;
    reg  [31:0] immediate;

    reg         ALUSrc;
    reg  [2:0]  ALUOp;

    wire [31:0] ALU_result;


    // DUT
    execute_unit DUT (
        .read_data1(read_data1),
        .read_data2(read_data2),
        .immediate(immediate),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp),
        .ALU_result(ALU_result)
    );


    initial begin

        // ==========================================
        // TEST 1: R-TYPE ADD
        // ADD x3, x1, x2
        // 25 + 17 = 42
        // ==========================================

        read_data1 = 32'd25;
        read_data2 = 32'd17;
        immediate  = 32'd100;

        ALUSrc = 1'b0;
        ALUOp  = 3'b000;

        #10;

        $display("--------------------------------");
        $display("TEST 1: R-TYPE ADD");
        $display("Result = %d", ALU_result);


        // ==========================================
        // TEST 2: R-TYPE SUB
        // 25 - 17 = 8
        // ==========================================

        ALUOp = 3'b001;

        #10;

        $display("--------------------------------");
        $display("TEST 2: R-TYPE SUB");
        $display("Result = %d", ALU_result);


        // ==========================================
        // TEST 3: I-TYPE ADDI
        // ADDI x3, x1, 10
        // 25 + 10 = 35
        // ==========================================

        immediate = 32'd10;

        ALUSrc = 1'b1;
        ALUOp  = 3'b000;

        #10;

        $display("--------------------------------");
        $display("TEST 3: I-TYPE ADDI");
        $display("Result = %d", ALU_result);


        // ==========================================
        // TEST 4: I-TYPE SUB
        // 25 - 10 = 15
        // ==========================================

        ALUOp = 3'b001;

        #10;

        $display("--------------------------------");
        $display("TEST 4: IMMEDIATE SUB");
        $display("Result = %d", ALU_result);


        // ==========================================
        // TEST 5: AND
        // ==========================================

        read_data1 = 32'h0F0F;
        read_data2 = 32'h00FF;

        ALUSrc = 1'b0;
        ALUOp  = 3'b010;

        #10;

        $display("--------------------------------");
        $display("TEST 5: AND");
        $display("Result = %h", ALU_result);


        // ==========================================
        // TEST 6: OR
        // ==========================================

        ALUOp = 3'b011;

        #10;

        $display("--------------------------------");
        $display("TEST 6: OR");
        $display("Result = %h", ALU_result);


        #10;

        $finish;

    end

endmodule