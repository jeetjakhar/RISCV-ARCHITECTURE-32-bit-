module memory_writeback_unit(
    input clk,
    input [31:0] ALU_result,
    input [31:0] write_data_memory,
    input MemWrite,
    input MemRead,
    input MemToReg,
    output [31:0] read_data,
    output [31:0] write_data
);

    data_memory data_mem (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .address(ALU_result),
        .write_data(write_data_memory),
        .read_data(read_data)
    );

    writeback_mux wb_mux (
        .alu_result(ALU_result),
        .read_data(read_data),
        .MemToReg(MemToReg),
        .write_data(write_data)
    );

endmodule