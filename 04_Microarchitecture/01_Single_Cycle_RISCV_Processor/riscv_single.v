// riscv_single.v - Single-Cycle RV32I Processor Top-Level Module (Enhanced)
`timescale 1ns / 1ps

module riscv_single (
    input clk,
    input rst_n
);

    // -------------------------------------------------------------
    // Internal Interconnect Wires
    // -------------------------------------------------------------
    wire [31:0] pc;
    wire [31:0] pc_next;
    wire [31:0] pc_plus4;
    wire [31:0] pc_target;
    wire [31:0] instr;

    wire [31:0] src_a;
    wire [31:0] rd2;
    wire [31:0] result;

    wire [31:0] imm_ext;

    wire [31:0] src_b;
    wire [31:0] alu_result;
    wire        zero;

    wire [31:0] read_data;

    // Control signals from controller
    wire        reg_write;
    wire [1:0]  imm_src;
    wire        alu_src;
    wire [2:0]  alu_control;
    wire        mem_write;
    wire [1:0]  result_src; // Upgraded to 2-bit
    wire        pc_src;

    // -------------------------------------------------------------
    // Instruction Fetch (IF) Stage
    // -------------------------------------------------------------
    mux2 #(.WIDTH(32)) u_pc_mux (
        .d0(pc_plus4),
        .d1(pc_target),
        .s (pc_src),
        .y (pc_next)
    );

    dff_pc u_dff_pc (
        .clk     (clk),
        .rst_n   (rst_n),
        .pc_next (pc_next),
        .pc      (pc)
    );

    pc_plus4 u_pc_plus4 (
        .pc       (pc),
        .pc_plus4 (pc_plus4)
    );

    instruction_memory u_imem (
        .addr  (pc),
        .instr (instr)
    );

    // -------------------------------------------------------------
    // Control Unit (Controller)
    // -------------------------------------------------------------
    controller u_controller (
        .op          (instr[6:0]),
        .funct3      (instr[14:12]),
        .funct7_5    (instr[30]),
        .zero        (zero),
        .result_src  (result_src),
        .mem_write   (mem_write),
        .pc_src      (pc_src),
        .alu_src     (alu_src),
        .imm_src     (imm_src),
        .reg_write   (reg_write),
        .alu_control (alu_control)
    );

    // -------------------------------------------------------------
    // Instruction Decode & Register Fetch (ID) Stage
    // -------------------------------------------------------------
    reg_file u_reg_file (
        .clk (clk),
        .we3 (reg_write),
        .a1  (instr[19:15]),
        .a2  (instr[24:20]),
        .a3  (instr[11:7]),
        .wd3 (result),
        .rd1 (src_a),
        .rd2 (rd2)
    );

    extend u_extend (
        .instr   (instr[31:7]),
        .immsrc  (imm_src),
        .imm_ext (imm_ext)
    );

    // -------------------------------------------------------------
    // Execute (EX) Stage
    // -------------------------------------------------------------
    mux2 #(.WIDTH(32)) u_srcb_mux (
        .d0(rd2),
        .d1(imm_ext),
        .s (alu_src),
        .y (src_b)
    );

    alu u_alu (
        .Src_A       (src_a),
        .Src_B       (src_b),
        .ALU_Control (alu_control),
        .ALU_Result  (alu_result),
        .Zero        (zero)
    );

    adder_32 u_pc_target_adder (
        .a        (pc),
        .b        (imm_ext),
        .sub_ctrl (1'b0),
        .sum      (pc_target),
        .cout     ()
    );

    // -------------------------------------------------------------
    // Memory (MEM) & Write-Back (WB) Stage
    // -------------------------------------------------------------
    data_memory u_dmem (
        .clk  (clk),
        .we   (mem_write),
        .addr (alu_result),
        .wd   (rd2),
        .rd   (read_data)
    );

    // Upgraded Result Multiplexer: 3-to-1 MUX
    // 00: ALUResult, 01: ReadData, 10: PCPlus4
    mux3 #(.WIDTH(32)) u_result_mux (
        .d0(alu_result),
        .d1(read_data),
        .d2(pc_plus4),
        .s (result_src),
        .y (result)
    );

endmodule