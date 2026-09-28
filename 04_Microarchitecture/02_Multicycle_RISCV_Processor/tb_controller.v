// tb_controller.v - Testbench for Top-level Controller
`timescale 1ns / 1ps

module tb_controller;

    reg        clk;
    reg        rst_n;
    reg  [6:0] op;
    reg  [2:0] funct3;
    reg        funct7_5;
    reg        zero;

    wire       pc_write;
    wire       adr_src;
    wire       mem_write;
    wire       ir_write;
    wire [1:0] result_src;
    wire [2:0] alu_control;
    wire [1:0] alu_src_a;
    wire [1:0] alu_src_b;
    wire [1:0] imm_src;
    wire       reg_write;

    // Instantiate Controller DUT
    controller uut (
        .clk         (clk),
        .rst_n       (rst_n),
        .op          (op),
        .funct3      (funct3),
        .funct7_5    (funct7_5),
        .zero        (zero),
        .pc_write    (pc_write),
        .adr_src     (adr_src),
        .mem_write   (mem_write),
        .ir_write    (ir_write),
        .result_src  (result_src),
        .alu_control (alu_control),
        .alu_src_a   (alu_src_a),
        .alu_src_b   (alu_src_b),
        .imm_src     (imm_src),
        .reg_write   (reg_write)
    );

    // Generate 100MHz Clock
    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("controller.vcd");
        $dumpvars(0, tb_controller);

        $monitor("Time=%0t | State=%0d | PCWrite=%b | RegW=%b | MemW=%b | ALUControl=%b | ImmSrc=%b",
                 $time, uut.u_main_fsm.current_state, pc_write, reg_write, mem_write, alu_control, imm_src);

        // Initialize signals
        clk      = 1'b0;
        rst_n    = 1'b0;
        op       = 7'b0000011; // lw
        funct3   = 3'b010;
        funct7_5 = 1'b0;
        zero     = 1'b0;

        #12;
        rst_n = 1'b1;

        // -------------------------------------------------------------
        // Test 1: Verify lw (5 cycles)
        // -------------------------------------------------------------
        op = 7'b0000011;
        #50;

        // -------------------------------------------------------------
        // Test 2: Verify R-type sub (4 cycles, ALUControl should be 3'b001)
        // -------------------------------------------------------------
        @(negedge clk);
        op       = 7'b0110011;
        funct3   = 3'b000;
        funct7_5 = 1'b1; // sub
        #40;

        // -------------------------------------------------------------
        // Test 3: Verify beq branch not taken (zero = 0 -> PCWrite should be 0)
        // -------------------------------------------------------------
        @(negedge clk);
        op       = 7'b1100011;
        funct3   = 3'b000;
        zero     = 1'b0;
        #30;

        // -------------------------------------------------------------
        // Test 4: Verify beq branch taken (zero = 1 -> PCWrite should be 1 at State 10)
        // -------------------------------------------------------------
        @(negedge clk);
        op       = 7'b1100011;
        zero     = 1'b1;
        #30;

        #20;
        $finish;
    end

endmodule