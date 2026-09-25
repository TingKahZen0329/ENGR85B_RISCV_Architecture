`timescale 1ns / 1ps

module tb_reg_file;

    // 1. Declare stimulus inputs as reg, outputs as wire
    reg         clk;
    reg         we3;
    reg  [4:0]  a1, a2, a3;
    reg  [31:0] wd3;
    wire [31:0] rd1, rd2;

    // 2. Instantiate the Device Under Test (DUT)
    reg_file uut (
        .clk(clk),
        .we3(we3),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2)
    );

    // 3. Generate a 100MHz clock (10ns period: 5ns low, 5ns high)
    always #5 clk = ~clk;

    // 4. Apply test vectors
    initial begin
        // Dump waveform for GTKWave analysis
        $dumpfile("reg_file.vcd");
        $dumpvars(0, tb_reg_file);

        // Initialize signals
        clk = 0;
        we3 = 0;
        a1  = 5'd0;
        a2  = 5'd0;
        a3  = 5'd0;
        wd3 = 32'd0;

        $monitor("Time=%0t | WE3=%b, A3=%d, WD3=%d | A1=%d, RD1=%d | A2=%d, RD2=%d",
                 $time, we3, a3, wd3, a1, rd1, a2, rd2);

        #10; // Wait for initial reset state to settle

        // Test Case 1: Write value 88 into register x1
        @(negedge clk); // Drive inputs on negative edge to satisfy setup/hold times
        we3 = 1'b1;
        a3  = 5'd1;
        wd3 = 32'd88;

        // Test Case 2: Write value 99 into register x2
        @(negedge clk);
        we3 = 1'b1;
        a3  = 5'd2;
        wd3 = 32'd99;

        // Test Case 3: Attempt to write 1234 into x0 (should be discarded by hardware)
        @(negedge clk);
        we3 = 1'b1;
        a3  = 5'd0;
        wd3 = 32'd1234;

        // Test Case 4: Disable write, perform dual-port simultaneous read (x1 and x2)
        @(negedge clk);
        we3 = 1'b0;
        a1  = 5'd1; // Expect rd1 = 88
        a2  = 5'd2; // Expect rd2 = 99

        #10;

        // Test Case 5: Verify x0 is hardwired to zero
        @(negedge clk);
        a1  = 5'd0; // Expect rd1 = 0, proving x0 remains unmodified
        a2  = 5'd1; // Expect rd2 = 88

        #20;
        $finish; // End simulation
    end

endmodule