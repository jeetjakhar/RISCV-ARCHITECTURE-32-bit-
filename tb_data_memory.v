module tb_data_memory;

    reg         clk;
    reg         MemWrite;
    reg         MemRead;
    reg  [31:0] address;
    reg  [31:0] write_data;

    wire [31:0] read_data;


    // DUT
    data_memory DUT (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );


    // Clock
    always #5 clk = ~clk;


    initial begin

        // Initial values
        clk       = 0;
        MemWrite  = 0;
        MemRead   = 0;
        address   = 0;
        write_data = 0;


        // ==========================================
        // TEST 1: STORE 25 at address 4
        // ==========================================

        #5;

        address    = 32'd4;
        write_data = 32'd25;
        MemWrite   = 1;

        #10;

        MemWrite = 0;


        // ==========================================
        // TEST 2: LOAD from address 4
        // ==========================================

        MemRead = 1;

        #5;

        $display("--------------------------------");
        $display("TEST 2: LOAD");
        $display("Address = %d", address);
        $display("Read Data = %d", read_data);


        // ==========================================
        // TEST 3: STORE 100 at address 8
        // ==========================================

        MemRead   = 0;
        address   = 32'd8;
        write_data = 32'd100;
        MemWrite  = 1;

        #10;

        MemWrite = 0;


        // ==========================================
        // TEST 4: LOAD from address 8
        // ==========================================

        MemRead = 1;

        #5;

        $display("--------------------------------");
        $display("TEST 4: LOAD");
        $display("Address = %d", address);
        $display("Read Data = %d", read_data);


        // ==========================================
        // TEST 5: Read with MemRead = 0
        // ==========================================

        MemRead = 0;

        #5;

        $display("--------------------------------");
        $display("TEST 5: READ DISABLED");
        $display("Read Data = %d", read_data);


        #10;

        $finish;

    end

endmodule