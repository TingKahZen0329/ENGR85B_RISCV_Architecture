// tb_mem.v - Testbench for Unified Memory
`timescale 1ns / 1ps

module tb_mem;

    reg         clk;
    reg         we;
    reg  [31:0] addr;
    reg  [31:0] wd;
    wire [31:0] rd;

    // Instantiate Device Under Test (DUT)
    mem uut (
        .clk  (clk),
        .we   (we),
        .addr (addr),
        .wd   (wd),
        .rd   (rd)
    );

    // Generate 100MHz Clock (10ns Period)
    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("mem.vcd");
        $dumpvars(0, tb_mem);

        $monitor("Time=%0t | we=%b | addr=0x%h (word_idx=%0d) | wd=0x%h | rd=0x%h",
                 $time, we, addr, addr[12:2], wd, rd);

        // Initialize signals
        clk  = 1'b0;
        we   = 1'b0;
        addr = 32'h0000_0000;
        wd   = 32'h0000_0000;

        // Preload sample test values directly into RAM for testing
        #2;
        uut.ram[0] = 32'h0050_0093; // Simulating an instruction at 0x0000
        uut.ram[1] = 32'h0080_00EF; // Simulating an instruction at 0x0004
        uut.ram[8] = 32'h1122_3344; // Simulating data at 0x0020

        // -------------------------------------------------------------
        // Test Case 1: Fetch Instructions (Asynchronous Read)
        // -------------------------------------------------------------
        #8;
        addr = 32'h0000_0000; // Expect rd = 0x00500093

        #10;
        addr = 32'h0000_0004; // Expect rd = 0x008000EF

        // -------------------------------------------------------------
        // Test Case 2: Read Data Word (Asynchronous Read)
        // -------------------------------------------------------------
        #10;
        addr = 32'h0000_0020; // Index 8, Expect rd = 0x11223344

        // -------------------------------------------------------------
        // Test Case 3: Write Data Word (Synchronous Store, sw)
        // -------------------------------------------------------------
        @(negedge clk);
        addr = 32'h0000_0040; // Index 16
        wd   = 32'hDEAD_BEEF;
        we   = 1'b1;

        @(negedge clk);
        we   = 1'b0; // Deassert write enable

        // -------------------------------------------------------------
        // Test Case 4: Read Back Written Value
        // -------------------------------------------------------------
        addr = 32'h0000_0040; // Expect rd = 0xDEADBEEF
        #10;

        // -------------------------------------------------------------
        // Test Case 5: Write Protection Verification (we = 0)
        // -------------------------------------------------------------
        @(negedge clk);
        wd   = 32'hCAFE_BABE;
        we   = 1'b0;

        #20;
        $finish;
    end

endmodule