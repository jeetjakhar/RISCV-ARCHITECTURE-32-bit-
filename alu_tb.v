module alu_tb;

    reg [31:0] A;
    reg [31:0] B;
    reg [2:0] aluop;

    wire [31:0] result;

    // DUT
    alu DUT (
        .A(A),
        .B(B),
        .aluop(aluop),
        .result(result)
    );

    initial begin

        // ADD
        A = 32'd10;
        B = 32'd5;
        aluop = 3'b000;

        #10;
        $display("ADD: %d + %d = %d", A, B, result);


        // SUB
        aluop = 3'b001;

        #10;
        $display("SUB: %d - %d = %d", A, B, result);


        // AND
        aluop = 3'b010;

        #10;
        $display("AND: %h & %h = %h", A, B, result);


        // OR
        aluop = 3'b011;

        #10;
        $display("OR: %h | %h = %h", A, B, result);


        // XOR
        aluop = 3'b100;

        #10;
        $display("XOR: %h ^ %h = %h", A, B, result);


        // SLT
        A = 32'd5;
        B = 32'd10;
        aluop = 3'b101;

        #10;
        $display("SLT: %d < %d = %d", A, B, result);


        #10;
        $finish;

    end

endmodule