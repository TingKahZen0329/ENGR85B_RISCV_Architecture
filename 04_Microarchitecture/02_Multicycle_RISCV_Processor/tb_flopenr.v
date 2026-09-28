// tb_flopenr.v - Testbench for Parameterized Flip-Flop with Enable and Reset
`timescale 1ns / 1ps

module tb_flopenr;

    localparam WIDTH = 32;

    // 1. Signal Declarations
    reg              clk;
    reg              rst_n;
    reg              en;
    reg  [WIDTH-1:0] d;
    wire [WIDTH-1:0] q;

    // 2. Instantiate Device Under Test (DUT)
    flopenr #(.WIDTH(WIDTH)) uut (
        .clk   (clk),
        .rst_n (rst_n),
        .en    (en),
        .d     (d),
        .q     (q)
    );

    // 3. Generate 100MHz Clock (10ns Period: 5ns Low, 5ns High)
    always begin
        #5 clk = ~clk;
    end

    // 4. Test Stimulus Generation
    initial begin
        // Dump waveform data for GTKWave analysis
        $dumpfile("flopenr.vcd");
        $dumpvars(0, tb_flopenr);

        // Terminal real-time monitoring
        $monitor("Time=%0t | rst_n=%b | en=%b | d=0x%h | q=0x%h",
                 $time, rst_n, en, d, q);

        // Initialize input signals
        clk   = 1'b0;
        rst_n = 1'b0; // Assert active-low reset
        en    = 1'b0;
        d     = 32'hAAAA_BBBB;

        // -------------------------------------------------------------
        // Test Case 1: Verify synchronous reset state (q must be 0)
        // -------------------------------------------------------------
        #12;
        rst_n = 1'b1; // Deassert reset

        // -------------------------------------------------------------
        // Test Case 2: Verify data latching when en = 1
        // -------------------------------------------------------------
        @(negedge clk);
        en = 1'b1;
        d  = 32'h1234_5678;

        @(negedge clk);
        // At this edge, q updates to 0x12345678
        d  = 32'h8765_4321;

        // -------------------------------------------------------------
        // Test Case 3: Verify data retention when en = 0 (Write disabled)
        // -------------------------------------------------------------
        @(negedge clk);
        en = 1'b0;
        d  = 32'hDEAD_BEEF; // Attempt to latch new value while disabled

        @(negedge clk);
        // q must hold previous value 0x87654321, ignoring DEADBEEF
        d  = 32'hCAFE_BABE;

        // -------------------------------------------------------------
        // Test Case 4: Asynchronous reset verification during operation
        // -------------------------------------------------------------
        #3;
        rst_n = 1'b0; // Assert reset asynchronously (independent of clk edge)

        #7;
        rst_n = 1'b1; // Release reset

        #20;
        $finish;
    end

endmodule