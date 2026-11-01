module tb_writeback_mux;

    reg  [31:0] alu_result;
    reg  [31:0] read_data;
    reg         MemToReg;

    wire [31:0] write_data;


    // DUT
    writeback_mux DUT (
        .alu_result(alu_result),
        .read_data(read_data),
        .MemToReg(MemToReg),
        .write_data(write_data)
    );


    initial begin

        // ==========================================
        // TEST 1: ALU result selected
        // ==========================================

        alu_result = 32'd25;
        read_data  = 32'd100;
        MemToReg   = 1'b0;

        #10;

        $display("--------------------------------");
        $display("TEST 1: ALU RESULT");
        $display("MemToReg = %b", MemToReg);
        $display("Write Data = %d", write_data);


        // ==========================================
        // TEST 2: Memory data selected
        // ==========================================

        MemToReg = 1'b1;

        #10;

        $display("--------------------------------");
        $display("TEST 2: MEMORY DATA");
        $display("MemToReg = %b", MemToReg);
        $display("Write Data = %d", write_data);


        // ==========================================
        // TEST 3: Different values, ALU selected
        // ==========================================

        alu_result = 32'd50;
        read_data  = 32'd200;
        MemToReg   = 1'b0;

        #10;

        $display("--------------------------------");
        $display("TEST 3: ALU RESULT");
        $display("Write Data = %d", write_data);


        // ==========================================
        // TEST 4: Different values, Memory selected
        // ==========================================

        MemToReg = 1'b1;

        #10;

        $display("--------------------------------");
        $display("TEST 4: MEMORY DATA");
        $display("Write Data = %d", write_data);


        #10;

        $finish;

    end

endmodule