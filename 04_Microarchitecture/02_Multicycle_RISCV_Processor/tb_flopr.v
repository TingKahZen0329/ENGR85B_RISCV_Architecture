// tb_flopr.v - Testbench for Standard Parameterized Flip-Flop
`timescale 1ns / 1ps

module tb_flopr;

    localparam WIDTH = 32;

    // 1. Signal Declarations
    reg              clk;
    reg              rst_n;
    reg  [WIDTH-1:0] d;
    wire [WIDTH-1:0] q;

    // 2. Instantiate Device Under Test (DUT)
    flopr #(.WIDTH(WIDTH)) uut (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (d),
        .q     (q)
    );

    // 3. Generate 100MHz Clock (10ns Period)
    always begin
        #5 clk = ~clk;
    end

    // 4. Test Stimulus Generation
    initial begin
        $dumpfile("flopr.vcd");
        $dumpvars(0, tb_flopr);

        $monitor("Time=%0t | rst_n=%b | d=0x%h | q=0x%h",
                 $time, rst_n, d, q);

        // Initialize signals
        clk   = 1'b0;
        rst_n = 1'b0; // Assert reset
        d     = 32'h0000_0000;

        // Release reset after 12ns
        #12;
        rst_n = 1'b1;

        // Apply new data on negative clock edge
        @(negedge clk);
        d = 32'hAAAA_5555;

        @(negedge clk);
        d = 32'h1234_ABCD;

        // Verify asynchronous reset mid-cycle
        #3;
        rst_n = 1'b0;

        #7;
        rst_n = 1'b1;
        d = 32'hFFFF_0000;

        #20;
        $finish;
    end

endmodule