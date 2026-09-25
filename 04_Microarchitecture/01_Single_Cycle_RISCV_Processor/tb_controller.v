`timescale 1ns / 1ps

module tb_controller;

    // Signal declarations
    reg  [6:0] op;
    reg  [2:0] funct3;
    reg        funct7_5;
    reg        zero;

    wire       result_src;
    wire       mem_write;
    wire       pc_src;
    wire       alu_src;
    wire [1:0] imm_src;
    wire       reg_write;
    wire [2:0] alu_control;

    // Instantiate Device Under Test (DUT)
    controller uut (
        .op(op),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .zero(zero),
        .result_src(result_src),
        .mem_write(mem_write),
        .pc_src(pc_src),
        .alu_src(alu_src),
        .imm_src(imm_src),
        .reg_write(reg_write),
        .alu_control(alu_control)
    );

    initial begin
        $dumpfile("controller.vcd");
        $dumpvars(0, tb_controller);

        $monitor("Time=%0t | op=%b | f3=%b | f7_5=%b | z=%b | RegW=%b ImmS=%b ALUS=%b MemW=%b ResS=%b PCS=%b ALUC=%b",
                 $time, op, funct3, funct7_5, zero,
                 reg_write, imm_src, alu_src, mem_write, result_src, pc_src, alu_control);

        // -------------------------------------------------------------
        // Test Case 1: lw instruction (I-type, op=0000011)
        // -------------------------------------------------------------
        op       = 7'b0000011;
        funct3   = 3'b010;
        funct7_5 = 1'b0;
        zero     = 1'b0;
        #10;

        // -------------------------------------------------------------
        // Test Case 2: sw instruction (S-type, op=0100011)
        // -------------------------------------------------------------
        op       = 7'b0100011;
        funct3   = 3'b010;
        funct7_5 = 1'b0;
        zero     = 1'b0;
        #10;

        // -------------------------------------------------------------
        // Test Case 3: or instruction (R-type, op=0110011, funct3=110)
        // -------------------------------------------------------------
        op       = 7'b0110011;
        funct3   = 3'b110;
        funct7_5 = 1'b0;
        zero     = 1'b0;
        #10;

        // -------------------------------------------------------------
        // Test Case 4: beq with condition not met (zero = 0)
        // -------------------------------------------------------------
        op       = 7'b1100011;
        funct3   = 3'b000;
        funct7_5 = 1'b0;
        zero     = 1'b0;
        #10;

        // -------------------------------------------------------------
        // Test Case 5: beq with condition met (zero = 1 -> pc_src = 1)
        // -------------------------------------------------------------
        zero     = 1'b1;
        #10;

        $finish;
    end

endmodule