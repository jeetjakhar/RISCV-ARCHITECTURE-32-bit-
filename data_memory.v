module data_memory(
    input         clk,
    input         MemWrite,
    input         MemRead,
    input  [31:0] address,
    input  [31:0] write_data,
    output [31:0] read_data
);

    // 256 words, each 32 bits
    reg [31:0] memory [0:255];

    // Synchronous write
    always @(posedge clk) begin
        if (MemWrite)
            memory[address[9:2]] <= write_data;
    end

    // Combinational read
    assign read_data = MemRead ? memory[address[9:2]] : 32'd0;

endmodule