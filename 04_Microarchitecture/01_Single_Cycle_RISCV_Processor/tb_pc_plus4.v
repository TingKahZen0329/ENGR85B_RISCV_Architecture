`timescale 1ns / 1ps

module tb_pc_plus4;

    reg  [31:0] pc;
    wire [31:0] pc_plus4;

    // Instantiate DUT
    pc_plus4 uut (
        .pc(pc),
        .pc_plus4(pc_plus4)
    );

    initial begin
        $dumpfile("pc_plus4.vcd");
        $dumpvars(0, tb_pc_plus4);

        $monitor("Time=%0t | PC=0x%h | PCPlus4=0x%h", $time, pc, pc_plus4);

        // Test Case 1: Initial reset address
        pc = 32'h0000_0000;
        #10;

        // Test Case 2: Lecture slide starting address
        pc = 32'h0000_1000;
        #10;

        // Test Case 3: Sequential step
        pc = 32'h0000_1004;
        #10;

        // Test Case 4: Boundary check
        pc = 32'h0000_1FFC;
        #10;

        #10;
        $finish;
    end

endmodule