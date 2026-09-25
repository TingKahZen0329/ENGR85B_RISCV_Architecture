`timescale 1ns / 1ps

module tb_dff_pc;

    // 1. Declare stimulus signals
    reg         clk;
    reg         rst_n;
    reg  [31:0] pc_next;
    wire [31:0] pc;

    // 2. Instantiate Device Under Test (DUT)
    dff_pc uut (
        .clk(clk),
        .rst_n(rst_n),
        .pc_next(pc_next),
        .pc(pc)
    );

    // 3. Generate 100MHz clock (10ns period)
    always #5 clk = ~clk;

    // 4. Test stimulus
    initial begin
        $dumpfile("dff_pc.vcd");
        $dumpvars(0, tb_dff_pc);

        $monitor("Time=%0t | rst_n=%b | pc_next=0x%h | pc=0x%h",
                 $time, rst_n, pc_next, pc);

        // Initialize signals
        clk     = 0;
        rst_n   = 0;      // Assert reset
        pc_next = 32'h0000_1000;

        #12;
        rst_n   = 1;      // Release reset

        // Test Case 1: Sequential instruction fetch (PC increments by 4)
        @(negedge clk);
        pc_next = 32'h0000_1004;

        @(negedge clk);
        pc_next = 32'h0000_1008;

        @(negedge clk);
        pc_next = 32'h0000_100C;

        // Test Case 2: Asynchronous reset verification during operation
        #3;
        rst_n = 0;        // Reset triggered asynchronously

        #7;
        rst_n = 1;        // Release reset again
        @(negedge clk);
        pc_next = 32'h0000_2000;

        #20;
        $finish;
    end

endmodule