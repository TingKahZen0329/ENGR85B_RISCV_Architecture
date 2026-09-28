// mem.v - Unified Instruction and Data Memory with $readmemh loader
`timescale 1ns / 1ps

module mem (
    input             clk,
    input             we,   // Write Enable (from MemWrite)
    input      [31:0] addr, // Memory Address (Byte-addressed from AdrSrc MUX)
    input      [31:0] wd,   // Write Data (from Register B)
    output     [31:0] rd    // Read Data (to Instruction Register or Data Register)
);

    // 2048 words (32-bit each), total capacity 8KB
    reg [31:0] ram [0:2047];
    integer i;

    initial begin
        // Initialize memory space to 0 (nop / addi x0, x0, 0)
        for (i = 0; i < 2048; i = i + 1) begin
            ram[i] = 32'h0000_0000;
        end

        // Load compiled RISC-V machine code
        $readmemh("program.hex", ram);
    end

    // Synchronous write on clock rising edge
    always @(posedge clk) begin
        if (we) begin
            ram[addr[12:2]] <= wd;
        end
    end

    // Asynchronous read (Word alignment: drop lower 2 bits)
    assign rd = ram[addr[12:2]];

endmodule