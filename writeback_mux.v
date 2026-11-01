module writeback_mux(
    input  [31:0] alu_result,
    input  [31:0] read_data,
    input         MemToReg,
    output [31:0] write_data
);

    assign write_data = MemToReg ? read_data : alu_result;

endmodule