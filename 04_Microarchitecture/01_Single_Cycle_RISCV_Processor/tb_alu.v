`timescale 1ns / 1ps

module tb_alu;

    // 1. Declare inputs as reg and outputs as wire
    reg  [31:0] Src_A;
    reg  [31:0] Src_B;
    reg  [2:0]  ALU_Control;
    wire [31:0] ALU_Result;
    wire        Zero;

    // 2. Instantiate Device Under Test (DUT)
    alu uut (
        .Src_A(Src_A),
        .Src_B(Src_B),
        .ALU_Control(ALU_Control),
        .ALU_Result(ALU_Result),
        .Zero(Zero)
    );

    // 3. Apply test stimulus
    initial begin
        // Generate waveform file for GTKWave
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);

        // Terminal monitor to log output values on changes
        $monitor("Time=%0t | Ctrl=%b | A=%d, B=%d | Result=%d (hex:%h), Zero=%b", 
                 $time, ALU_Control, Src_A, Src_B, ALU_Result, ALU_Result, Zero);

        // Case 1: ADD operation (10 + 20 = 30)
        Src_A = 32'd10; Src_B = 32'd20; ALU_Control = 3'b000;
        #10; // Wait 10ns for combinational logic to settle

        // Case 2: SUB operation (30 - 10 = 20)
        Src_A = 32'd30; Src_B = 32'd10; ALU_Control = 3'b001;
        #10;

        // Case 3: SUB with equal inputs to test Zero flag (25 - 25 = 0, Zero -> 1)
        Src_A = 32'd25; Src_B = 32'd25; ALU_Control = 3'b001;
        #10;

        // Case 4: Bitwise AND operation (12 & 10 = 8, 1100 & 1010 = 1000)
        Src_A = 32'd12; Src_B = 32'd10; ALU_Control = 3'b010;
        #10;

        // Case 5: Bitwise OR operation (12 | 10 = 14, 1100 | 1010 = 1110)
        Src_A = 32'd12; Src_B = 32'd10; ALU_Control = 3'b011;
        #10;

        // Case 6: SLT true condition (5 < 10 -> Result should be 1)
        Src_A = 32'd5;  Src_B = 32'd10; ALU_Control = 3'b101;
        #10;

        // Case 7: SLT false condition (15 < 10 -> Result should be 0)
        Src_A = 32'd15; Src_B = 32'd10; ALU_Control = 3'b101;
        #10;

        // Case 8: Default fallback test with unused control code (output should be 0)
        Src_A = 32'd10; Src_B = 32'd20; ALU_Control = 3'b111;
        #10;

        $finish; // End simulation
    end

endmodule