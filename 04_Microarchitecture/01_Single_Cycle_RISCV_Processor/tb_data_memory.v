`timescale 1ns / 1ps

module tb_data_memory;

    // Signal declarations
    reg         clk;
    reg         we;
    reg  [31:0] addr;
    reg  [31:0] wd;
    wire [31:0] rd;

    // Instantiate Device Under Test (DUT)
    data_memory uut (
        .clk  (clk),
        .we   (we),
        .addr (addr),
        .wd   (wd),
        .rd   (rd)
    );

    // Clock generation (10ns period, 100MHz)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("data_memory.vcd");
        $dumpvars(0, tb_data_memory);

        $monitor("Time=%0t | we=%b | addr=0x%h (idx=%0d) | wd=0x%h | rd=0x%h",
                 $time, we, addr, addr[31:2], wd, rd);

        // Initialize signals
        clk  = 0;
        we   = 0;
        addr = 32'h0;
        wd   = 32'h0;

        // -------------------------------------------------------------
        // Test Case 1: Preload value and asynchronous read
        // (Simulates slide example: reading value 10)
        // -------------------------------------------------------------
        #5;
        uut.mem[8] = 32'd10; // Load 10 into Index 8 (Byte address 0x00000020)
        addr = 32'h0000_0020;
        #10;

        // -------------------------------------------------------------
        // Test Case 2: Synchronous write (Store Word, sw)
        // Write 0xDEADBEEF into address 0x00000004 (Index 1)
        // -------------------------------------------------------------
        @(negedge clk);
        addr = 32'h0000_0004;
        wd   = 32'hDEAD_BEEF;
        we   = 1;

        @(negedge clk);
        we   = 0; // Deassert write enable

        // -------------------------------------------------------------
        // Test Case 3: Read back written value (Load Word, lw)
        // -------------------------------------------------------------
        addr = 32'h0000_0004;
        #10;

        // -------------------------------------------------------------
        // Test Case 4: Attempt write when we=0 (Verify write-protect)
        // -------------------------------------------------------------
        @(negedge clk);
        wd   = 32'h1234_5678;
        we   = 0;

        #20;
        $finish;
    end

endmodule