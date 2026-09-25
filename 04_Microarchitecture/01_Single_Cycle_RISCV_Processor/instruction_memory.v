// instruction_memory.v - Instruction Memory with $readmemh loader
`timescale 1ns / 1ps

module instruction_memory (
    input  [31:0] addr,
    output [31:0] instr
);

    // 2048 words (32-bit each), total capacity 8KB
    reg [31:0] mem [0:2047];
    integer i;

    initial begin
        // Initialize all memory entries to 0 (nop / addi x0, x0, 0)
        for (i = 0; i < 2048; i = i + 1) begin
            mem[i] = 32'h0000_0000;
        end

        // Load machine code from an external hex file
        $readmemh("program.hex", mem);
        $display("[IMEM DEBUG] mem[1024] = 0x%h", mem[1024]);
    end

    
    assign instr = mem[addr[12:2]];

endmodule