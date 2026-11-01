module tb_memory_writeback_unit;

    reg clk;
    reg [31:0] ALU_result;
    reg [31:0] write_data_memory;
    reg MemWrite;
    reg MemRead;
    reg MemToReg;

    wire [31:0] read_data;
    wire [31:0] write_data;

    memory_writeback_unit DUT (
        .clk(clk),
        .ALU_result(ALU_result),
        .write_data_memory(write_data_memory),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemToReg(MemToReg),
        .read_data(read_data),
        .write_data(write_data)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        ALU_result = 0;
        write_data_memory = 0;
        MemWrite = 0;
        MemRead = 0;
        MemToReg = 0;

        // TEST 1: STORE 25 at address 4

        #5;

        ALU_result = 32'd4;
        write_data_memory = 32'd25;
        MemWrite = 1;
        MemRead = 0;

        #10;

        MemWrite = 0;

        $display("--------------------------------");
        $display("TEST 1: STORE");
        $display("Address = %d", ALU_result);
        $display("Data Stored = %d", write_data_memory);


        // TEST 2: LOAD from address 4

        MemRead = 1;
        MemToReg = 1;

        #5;

        $display("--------------------------------");
        $display("TEST 2: LOAD");
        $display("Address = %d", ALU_result);
        $display("Memory Read Data = %d", read_data);
        $display("Write-back Data = %d", write_data);


        // TEST 3: ALU WRITE-BACK

        MemRead = 0;
        MemToReg = 0;

        ALU_result = 32'd42;

        #10;

        $display("--------------------------------");
        $display("TEST 3: ALU WRITE-BACK");
        $display("ALU Result = %d", ALU_result);
        $display("Write-back Data = %d", write_data);


        // TEST 4: STORE 100 at address 8

        MemWrite = 1;
        MemRead = 0;

        ALU_result = 32'd8;
        write_data_memory = 32'd100;

        #10;

        MemWrite = 0;


        // TEST 5: LOAD from address 8

        MemRead = 1;
        MemToReg = 1;

        #5;

        $display("--------------------------------");
        $display("TEST 5: SECOND LOAD");
        $display("Address = %d", ALU_result);
        $display("Memory Read Data = %d", read_data);
        $display("Write-back Data = %d", write_data);

        #10;

        $finish;

    end

endmodule