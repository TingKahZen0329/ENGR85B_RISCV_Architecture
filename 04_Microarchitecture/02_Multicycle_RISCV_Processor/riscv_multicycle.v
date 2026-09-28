// riscv_multicycle.v - Top-level Core of Multicycle RISC-V Processor
`timescale 1ns / 1ps

module riscv_multicycle (
    input             clk,
    input             rst_n,
    // Memory Interface
    input      [31:0] readdata,
    output            mem_write,
    output     [31:0] adr,
    output     [31:0] writedata
);

    // Interconnect wires between Controller and Datapath
    wire       pc_write;
    wire       adr_src;
    wire       ir_write;
    wire [1:0] result_src;
    wire [2:0] alu_control;
    wire [1:0] alu_src_a;
    wire [1:0] alu_src_b;
    wire [1:0] imm_src;
    wire       reg_write;
    wire       zero;
    wire [6:0] op;
    wire [2:0] funct3;
    wire       funct7_5;

    // 1. Controller Instance
    controller u_controller (
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

    // 2. Datapath Instance
    datapath u_datapath (
        .clk         (clk),
        .rst_n       (rst_n),
        .pc_write    (pc_write),
        .adr_src     (adr_src),
        .ir_write    (ir_write),
        .result_src  (result_src),
        .alu_control (alu_control),
        .alu_src_a   (alu_src_a),
        .alu_src_b   (alu_src_b),
        .imm_src     (imm_src),
        .reg_write   (reg_write),
        .zero        (zero),
        .op          (op),
        .funct3      (funct3),
        .funct7_5    (funct7_5),
        .readdata    (readdata),
        .adr         (adr),
        .writedata   (writedata)
    );

endmodule