module tb_register_file;

    // Clock and control
    reg clk;
    reg RegWrite;

    // Register addresses
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;

    // Data to be written
    reg [31:0] write_data;

    // Data read from register file
    wire [31:0] read_data1;
    wire [31:0] read_data2;


    // Instantiate Register File
    register_file DUT (
        .clk(clk),
        .RegWrite(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );


    // Clock generation
    always #5 clk = ~clk;


    // Test sequence
    initial begin

        // Initial values
        clk = 0;
        RegWrite = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;


        // --------------------------------
        // TEST 1: Write 42 into x5
        // --------------------------------

        #10;

        rd = 5;
        write_data = 32'd42;
        RegWrite = 1;

        #10;

        RegWrite = 0;


        // --------------------------------
        // TEST 2: Read x5
        // --------------------------------

        rs1 = 5;
        rs2 = 5;

        #5;

        $display("TEST 2:");
        $display("read_data1 = %d", read_data1);
        $display("read_data2 = %d", read_data2);


        // --------------------------------
        // TEST 3: Try writing to x0
        // --------------------------------

        rd = 0;
        write_data = 32'd100;
        RegWrite = 1;

        #10;

        RegWrite = 0;

        rs1 = 0;
        rs2 = 0;

        #5;

        $display("TEST 3:");
        $display("x0 read_data1 = %d", read_data1);
        $display("x0 read_data2 = %d", read_data2);


        // --------------------------------
        // TEST 4: Write different values
        // --------------------------------

        rd = 1;
        write_data = 32'd25;
        RegWrite = 1;

        #10;

        rd = 2;
        write_data = 32'd17;

        #10;

        RegWrite = 0;


        // Read x1 and x2
        rs1 = 1;
        rs2 = 2;

        #5;

        $display("TEST 4:");
        $display("x1 = %d", read_data1);
        $display("x2 = %d", read_data2);


        // --------------------------------
        // End simulation
        // --------------------------------

        #10;

        $finish;

    end

endmodule