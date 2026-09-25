`timescale 1ns / 1ps

module tb_adder_32;

    // Stimulus signal declarations (use reg for DUT inputs)
    reg  [31:0] a;
    reg  [31:0] b;
    reg         sub_ctrl;

    // Response signal declarations (use wire for DUT outputs)
    wire [31:0] sum;
    wire        cout;

    // 1. Instantiate the Unit Under Test (UUT)
    adder_32 uut (
        .a        (a),
        .b        (b),
        .sub_ctrl (sub_ctrl),
        .sum      (sum),
        .cout     (cout)
    );

    // 2. Apply test stimulus
    initial begin
        // Dump waveform data for GTKWave viewing
        $dumpfile("adder_32.vcd");
        $dumpvars(0, tb_adder_32);

        // Terminal formatted output monitor
        $monitor("Time=%0t | a=%d, b=%d, sub=%b | sum=%d (hex:%h), cout=%b", 
                 $time, a, b, sub_ctrl, sum, sum, cout);

        // Test Case 1: Basic positive addition (10 + 20 = 30)
        a = 32'd10; b = 32'd20; sub_ctrl = 1'b0;
        #10; // Wait 10ns for signals to settle

        // Test Case 2: Basic positive subtraction (50 - 20 = 30)
        a = 32'd50; b = 32'd20; sub_ctrl = 1'b1;
        #10;

        // Test Case 3: Subtraction yielding a negative number (10 - 25 = -15)
        a = 32'd10; b = 32'd25; sub_ctrl = 1'b1;
        #10;

        // Test Case 4: Overflow carry-out (maximum 32-bit integer + 1)
        a = 32'hFFFF_FFFF; b = 32'd1; sub_ctrl = 1'b0;
        #10;

        $finish; // Terminate simulation
    end

endmodule