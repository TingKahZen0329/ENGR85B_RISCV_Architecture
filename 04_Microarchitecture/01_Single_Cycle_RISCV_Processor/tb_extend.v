`timescale 1ns / 1ps

module tb_extend;

    // 1. Declare testbench stimulus signals
    reg  [31:7] instr;
    reg  [1:0]  immsrc;
    wire [31:0] imm_ext;

    // Assign to a signed wire for iverilog $monitor compatibility
    wire signed [31:0] imm_ext_signed;
    assign imm_ext_signed = imm_ext;

    // 2. Instantiate the Device Under Test (DUT)
    extend uut (
        .instr(instr),
        .immsrc(immsrc),
        .imm_ext(imm_ext)
    );

    // 3. Apply test stimulus
    initial begin
        // Dump waveform for GTKWave analysis
        $dumpfile("extend.vcd");
        $dumpvars(0, tb_extend);

        // Monitor signal changes using only simple signals
        $monitor("Time=%0t | ImmSrc=%b | Instr[31:7]=0x%h | ImmExt=0x%h (%0d)",
                 $time, immsrc, instr, imm_ext, imm_ext_signed);

        // -------------------------------------------------------------
        // Test Case 1: I-type positive immediate (e.g., addi x1, x0, 5)
        // Immediate 12'd5 = 12'b0000_0000_0101, located at [31:20]
        // -------------------------------------------------------------
        immsrc = 2'b00;
        instr  = 25'b0;
        instr[31:20] = 12'd5;
        #10;

        // -------------------------------------------------------------
        // Test Case 2: I-type negative immediate (Lecture example: lw x6, -4(x9))
        // Immediate -4 = 12'hFFC (12'b1111_1111_1100), located at [31:20]
        // -------------------------------------------------------------
        immsrc = 2'b00;
        instr[31:20] = 12'hFFC;
        #10;

        // -------------------------------------------------------------
        // Test Case 3: S-type negative immediate (e.g., sw x5, -8(x2))
        // Immediate -8 = 12'b1111_1111_1000
        // [31:25] gets 7'b1111111, [11:7] gets 5'b11000
        // -------------------------------------------------------------
        immsrc = 2'b01;
        instr = 25'b0;
        instr[31:25] = 7'b1111111;
        instr[11:7]  = 5'b11000;
        #10;

        // -------------------------------------------------------------
        // Test Case 4: B-type branch offset (e.g., beq target +16 bytes)
        // 13-bit offset +16 = 13'b0_0000_0001_0000
        // -------------------------------------------------------------
        immsrc = 2'b10;
        instr = 25'b0;
        instr[31]    = 1'b0;       // imm[12]
        instr[7]     = 1'b0;       // imm[11]
        instr[30:25] = 6'b000000;  // imm[10:5]
        instr[11:8]  = 4'b1000;    // imm[4:1]
        #10;

        // -------------------------------------------------------------
        // Test Case 5: J-type jump offset (e.g., jal target -4 bytes)
        // 21-bit offset -4 = 21'h1FFFFC
        // -------------------------------------------------------------
        immsrc = 2'b11;
        instr = 25'b0;
        instr[31]    = 1'b1;           // imm[20]
        instr[19:12] = 8'hFF;          // imm[19:12]
        instr[20]    = 1'b1;           // imm[11]
        instr[30:21] = 10'b1111111110; // imm[10:1]
        #10;

        #20;
        $finish; // Terminate simulation
    end

endmodule