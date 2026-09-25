`timescale 1ns / 1ps

module tb_instruction_memory;

    // 1. Declare stimulus signals
    reg  [31:0] addr;
    wire [31:0] instr;

    // 2. Instantiate Device Under Test (DUT)
    instruction_memory uut (
        .addr(addr),
        .instr(instr)
    );

    // 3. Test stimulus
    initial begin
        $dumpfile("instruction_memory.vcd");
        $dumpvars(0, tb_instruction_memory);

        $monitor("Time=%0t | Addr=0x%h (Index=%0d) | Instr=0x%h",
                 $time, addr, addr[31:2], instr);


        uut.mem[0] = 32'h00500093;
        uut.mem[1] = 32'hFFC4A303;
        uut.mem[2] = 32'h001303B3;


        addr = 32'h0000_0000; // Word 0 (Index 0) -> Expect 0x00500093
        #10;

        addr = 32'h0000_0004; // Word 1 (Index 1) -> Expect 0xFFC4A303
        #10;

        addr = 32'h0000_0008; // Word 2 (Index 2) -> Expect 0x001303B3
        #10;

        addr = 32'h0000_000C; // Word 3 (Index 3) -> Expect 0x00000000 (Empty)
        #10;

        #10;
        $finish;
    end

endmodule