// tb_main_fsm.v - Testbench for Multicycle Main Finite State Machine
`timescale 1ns / 1ps

module tb_main_fsm;

    // 1. Signal Declarations
    reg        clk;
    reg        rst_n;
    reg  [6:0] op;

    wire       pc_update;
    wire       branch;
    wire       reg_write;
    wire       mem_write;
    wire       ir_write;
    wire       adr_src;
    wire [1:0] result_src;
    wire [1:0] alu_src_a;
    wire [1:0] alu_src_b;
    wire [1:0] alu_op;

    // 2. Instantiate Device Under Test (DUT)
    main_fsm uut (
        .clk        (clk),
        .rst_n      (rst_n),
        .op         (op),
        .pc_update  (pc_update),
        .branch     (branch),
        .reg_write  (reg_write),
        .mem_write  (mem_write),
        .ir_write   (ir_write),
        .adr_src    (adr_src),
        .result_src (result_src),
        .alu_src_a  (alu_src_a),
        .alu_src_b  (alu_src_b),
        .alu_op     (alu_op)
    );

    // 3. Generate 100MHz Clock (10ns Period)
    always begin
        #5 clk = ~clk;
    end

    // 4. Test Stimulus Generation
    initial begin
        // Waveform dump for GTKWave analysis
        $dumpfile("main_fsm.vcd");
        $dumpvars(0, tb_main_fsm);

        // Real-time console monitoring
        $monitor("Time=%0t | State=%0d | op=0x%h | IRW=%b PCUp=%b RegW=%b MemW=%b Br=%b",
                 $time, uut.current_state, op, ir_write, pc_update, reg_write, mem_write, branch);

        // Initialize signals
        clk   = 1'b0;
        rst_n = 1'b0; // Assert reset
        op    = 7'b0000011; // Default to lw opcode

        // Release reset after 12ns
        #12;
        rst_n = 1'b1;

        // -------------------------------------------------------------
        // Test Case 1: Verify lw instruction 5-cycle path
        // S0: Fetch -> S1: Decode -> S2: MemAdr -> S3: MemRead -> S4: MemWB -> S0
        // -------------------------------------------------------------
        op = 7'b0000011; // lw opcode
        #50;

        // -------------------------------------------------------------
        // Test Case 2: Verify R-type instruction 4-cycle path
        // S0: Fetch -> S1: Decode -> S6: ExecuteR -> S7: ALUWB -> S0
        // -------------------------------------------------------------
        @(negedge clk);
        op = 7'b0110011; // R-type opcode
        #40;

        // -------------------------------------------------------------
        // Test Case 3: Verify beq instruction 3-cycle path
        // S0: Fetch -> S1: Decode -> S10: BEQ -> S0
        // -------------------------------------------------------------
        @(negedge clk);
        op = 7'b1100011; // beq opcode
        #30;

        // -------------------------------------------------------------
        // Test Case 4: Verify jal instruction 4-cycle path
        // S0: Fetch -> S1: Decode -> S9: JAL -> S7: ALUWB -> S0
        // -------------------------------------------------------------
        @(negedge clk);
        op = 7'b1101111; // jal opcode
        #40;

        // -------------------------------------------------------------
        // Test Case 5: Verify sw instruction 4-cycle path
        // S0: Fetch -> S1: Decode -> S2: MemAdr -> S5: MemWrite -> S0
        // -------------------------------------------------------------
        @(negedge clk);
        op = 7'b0100011; // sw opcode
        #40;

        // -------------------------------------------------------------
        // Test Case 6: Verify I-type ALU (e.g. addi) 4-cycle path
        // S0: Fetch -> S1: Decode -> S8: ExecuteI -> S7: ALUWB -> S0
        // -------------------------------------------------------------
        @(negedge clk);
        op = 7'b0010011; // I-type ALU opcode
        #40;

        #20;
        $finish;
    end

endmodule