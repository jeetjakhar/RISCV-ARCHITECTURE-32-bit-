module tb_alu_mux;

    reg  [31:0] read_data2;
    reg  [31:0] immediate;
    reg         ALUSrc;

    wire [31:0] alu_input_B;


    // DUT
    alu_mux DUT (
        .read_data2(read_data2),
        .immediate(immediate),
        .ALUSrc(ALUSrc),
        .alu_input_B(alu_input_B)
    );


    initial begin

        // --------------------------------
        // TEST 1: Select Register Value
        // --------------------------------

        read_data2 = 32'd25;
        immediate  = 32'd100;
        ALUSrc     = 1'b0;

        #10;

        $display("TEST 1:");
        $display("ALUSrc = %b, ALU Input B = %d",
                 ALUSrc, alu_input_B);


        // --------------------------------
        // TEST 2: Select Immediate
        // --------------------------------

        ALUSrc = 1'b1;

        #10;

        $display("TEST 2:");
        $display("ALUSrc = %b, ALU Input B = %d",
                 ALUSrc, alu_input_B);


        // --------------------------------
        // TEST 3: Different values
        // --------------------------------

        read_data2 = 32'd50;
        immediate  = 32'd200;
        ALUSrc     = 1'b0;

        #10;

        $display("TEST 3:");
        $display("ALUSrc = %b, ALU Input B = %d",
                 ALUSrc, alu_input_B);


        ALUSrc = 1'b1;

        #10;

        $display("TEST 4:");
        $display("ALUSrc = %b, ALU Input B = %d",
                 ALUSrc, alu_input_B);


        #10;

        $finish;

    end

endmodule