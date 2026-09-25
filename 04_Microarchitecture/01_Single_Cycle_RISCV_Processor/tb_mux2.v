`timescale 1ns / 1ps

module tb_mux2;

    // Testbench parameter
    localparam WIDTH = 32;

    // Signal declarations
    reg  [WIDTH-1:0] d0;
    reg  [WIDTH-1:0] d1;
    reg              s;
    wire [WIDTH-1:0] y;

    // Instantiate Device Under Test (DUT)
    mux2 #(.WIDTH(WIDTH)) uut (
        .d0(d0),
        .d1(d1),
        .s(s),
        .y(y)
    );

    initial begin
        // Waveform dump configuration
        $dumpfile("mux2.vcd");
        $dumpvars(0, tb_mux2);

        // Display monitor header and signals
        $monitor("Time=%0t | s=%b | d0=0x%h | d1=0x%h | y=0x%h", 
                 $time, s, d0, d1, y);

        // -------------------------------------------------------------
        // Test Case 1: Select input d0 (s = 0)
        // -------------------------------------------------------------
        d0 = 32'hAAAA_AAAA;
        d1 = 32'h5555_5555;
        s  = 1'b0;
        #10;

        // -------------------------------------------------------------
        // Test Case 2: Select input d1 (s = 1)
        // -------------------------------------------------------------
        s  = 1'b1;
        #10;

        // -------------------------------------------------------------
        // Test Case 3: Simulate PC multiplexer behavior (PCPlus4 vs PCTarget)
        // -------------------------------------------------------------
        d0 = 32'h0000_1004; // Sequential address (PC + 4)
        d1 = 32'h0000_1000; // Branch target address
        s  = 1'b0;          // Select PCPlus4
        #10;

        s  = 1'b1;          // Take branch (select PCTarget)
        #10;

        // -------------------------------------------------------------
        // Test Case 4: Simulate ALU source multiplexer (RD2 vs ImmExt)
        // -------------------------------------------------------------
        d0 = 32'h0000_000A; // Register RD2 value (10)
        d1 = 32'hFFFF_FFFC; // Sign-extended immediate (-4)
        s  = 1'b0;          // R-type: select register RD2
        #10;

        s  = 1'b1;          // I-type / Load: select immediate
        #10;

        $finish;
    end

endmodule