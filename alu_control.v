module alu_control(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg [2:0] aluop
);

always @(*) begin

    case(ALUOp)

        // LOAD / STORE
        // Address = rs1 + immediate
        2'b00: begin
            aluop = 3'b000;   // ADD
        end


        // BRANCH
        2'b01: begin
            aluop = 3'b001;   // SUB
        end


        // R-TYPE
        2'b10: begin

            case(funct3)

                3'b000: begin
                    if(funct7 == 7'b0100000)
                        aluop = 3'b001;   // SUB
                    else
                        aluop = 3'b000;   // ADD
                end

                3'b111:
                    aluop = 3'b010;       // AND

                3'b110:
                    aluop = 3'b011;       // OR

                3'b100:
                    aluop = 3'b100;       // XOR

                3'b010:
                    aluop = 3'b101;       // SLT

                default:
                    aluop = 3'b000;

            endcase

        end


        // I-TYPE arithmetic
        2'b11: begin

            case(funct3)

                3'b000:
                    aluop = 3'b000;       // ADDI

                3'b111:
                    aluop = 3'b010;       // ANDI

                3'b110:
                    aluop = 3'b011;       // ORI

                3'b100:
                    aluop = 3'b100;       // XORI

                3'b010:
                    aluop = 3'b101;       // SLTI

                default:
                    aluop = 3'b000;

            endcase

        end


        default:
            aluop = 3'b000;

    endcase

end

endmodule