// tb_mux3.v - Testbench for Parameterized 3-to-1 Multiplexer
`timescale 1ns / 1ps

module tb_mux3;

    localparam WIDTH = 32;

    // 1. Signal Declarations
    reg  [WIDTH-1:0] d0;
    reg  [WIDTH-1:0] d1;
    reg  [WIDTH-1:0] d2;
    reg  [1:0]       s;
    wire [WIDTH-1:0] y;

    // 2. Instantiate Device Under Test (DUT)
    mux3 #(.WIDTH(WIDTH)) uut (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .s (s),
        .y (y)
    );

    // 3. Test Stimulus Generation
    initial begin
        $dumpfile("mux3.vcd");
        $dumpvars(0, tb_mux3);

        $monitor("Time=%0t | s=%b | d0=0x%h | d1=0x%h | d2=0x%h | y=0x%h",
                 $time, s, d0, d1, d2, y);

        // Initialize input data channels
        d0 = 32'hAAAA_AAAA; // Channel 00
        d1 = 32'hBBBB_BBBB; // Channel 01
        d2 = 32'hCCCC_CCCC; // Channel 10
        s  = 2'b00;

        // -------------------------------------------------------------
        // Test Case 1: Select Channel 0 (s = 2'b00) -> Expect d0
        // -------------------------------------------------------------
        #10;
        s = 2'b00;

        // -------------------------------------------------------------
        // Test Case 2: Select Channel 1 (s = 2'b01) -> Expect d1
        // -------------------------------------------------------------
        #10;
        s = 2'b01;

        // -------------------------------------------------------------
        // Test Case 3: Select Channel 2 (s = 2'b10) -> Expect d2
        // -------------------------------------------------------------
        #10;
        s = 2'b10;

        // -------------------------------------------------------------
        // Test Case 4: Default fallback (s = 2'b11) -> Expect 0
        // -------------------------------------------------------------
        #10;
        s = 2'b11;

        // -------------------------------------------------------------
        // Test Case 5: Realistic ALUSrcB Simulation
        // (d0: Reg B, d1: ImmExt, d2: Constant 4)
        // -------------------------------------------------------------
        #10;
        d0 = 32'd20;        // Reg B
        d1 = 32'hFFFF_FFFC; // ImmExt (-4)
        d2 = 32'd4;         // Constant 4

        s  = 2'b10;         // Select Constant 4 for PC+4 fetch
        #10;
        s  = 2'b01;         // Select ImmExt for Address calculation
        #10;
        s  = 2'b00;         // Select Reg B for R-type ALU operation
        #10;

        $finish;
    end

endmodule