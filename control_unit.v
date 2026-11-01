module control_unit(

    input  [6:0] opcode,
    input  [2:0] funct3,
    input  [6:0] funct7,

    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg Jump,
    output reg ALUSrc,
    output reg [1:0] ALUOp

);

always @(*) begin

    // Default assignments
    RegWrite = 0;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
    Jump     = 0;
    ALUSrc   = 0;
    ALUOp    = 2'b00;

    case(opcode)

        // R-Type
        7'b0110011: begin
            RegWrite = 1;
            ALUSrc   = 0;
            ALUOp    = 2'b10;
        end

        // Load Word
        7'b0000011: begin
            RegWrite = 1;
            MemRead  = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b00;
        end

        // Store Word
        7'b0100011: begin
            MemWrite = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b00;
        end

        // Branch
        7'b1100011: begin
            Branch = 1;
            ALUOp  = 2'b01;
        end

        // Jump
        7'b1101111: begin
            Jump     = 1;
            RegWrite = 1;
        end
        
        // I-Type Arithmetic
        7'b0010011: begin
            RegWrite = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b11;
        end 

        default: begin
        end

    endcase

end

endmodule