module tb_imm_gen;

    reg  [31:0] instruction;
    reg  [2:0]  imm_type;

    wire [31:0] immediate;


    // DUT
    imm_gen DUT (
        .instruction(instruction),
        .imm_type(imm_type),
        .immediate(immediate)
    );


    initial begin

        // ==========================================
        // TEST 1: I-TYPE
        // Example immediate = 10
        // ==========================================

        instruction = 32'b00000000101000001000000110010011;
        imm_type = 3'b001;

        #10;

        $display("--------------------------------");
        $display("I-TYPE");
        $display("Immediate = %d", $signed(immediate));


        // ==========================================
        // TEST 2: S-TYPE
        // Example immediate = 20
        // ==========================================

        instruction = 32'b00000000001000001010101000100011;
        imm_type = 3'b010;

        #10;

        $display("--------------------------------");
        $display("S-TYPE");
        $display("Immediate = %d", $signed(immediate));


        // ==========================================
        // TEST 3: B-TYPE
        // Example branch offset
        // ==========================================

        instruction = 32'b00000000001000001000010001100011;
        imm_type = 3'b011;

        #10;

        $display("--------------------------------");
        $display("B-TYPE");
        $display("Immediate = %d", $signed(immediate));


        // ==========================================
        // TEST 4: J-TYPE
        // Example JAL immediate
        // ==========================================

        instruction = 32'b00000000001000000000000011101111;
        imm_type = 3'b100;

        #10;

        $display("--------------------------------");
        $display("J-TYPE");
        $display("Immediate = %d", $signed(immediate));


        // ==========================================
        // TEST 5: DEFAULT
        // ==========================================

        instruction = 32'd0;
        imm_type = 3'b000;

        #10;

        $display("--------------------------------");
        $display("DEFAULT");
        $display("Immediate = %d", $signed(immediate));


        #10;

        $finish;

    end

endmodule