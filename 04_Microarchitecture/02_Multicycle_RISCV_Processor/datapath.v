// datapath.v - Complete Datapath for Multicycle RISC-V Processor
`timescale 1ns / 1ps

module datapath (
    input             clk,
    input             rst_n,
    // Control inputs from controller
    input             pc_write,
    input             adr_src,
    input             ir_write,
    input      [1:0]  result_src,
    input      [2:0]  alu_control,
    input      [1:0]  alu_src_a,
    input      [1:0]  alu_src_b,
    input      [1:0]  imm_src,
    input             reg_write,
    // Status flag output to controller
    output            zero,
    // Instruction fields output to controller
    output     [6:0]  op,
    output     [2:0]  funct3,
    output            funct7_5,
    // Memory interface
    input      [31:0] readdata,
    output     [31:0] adr,
    output     [31:0] writedata
);

    // Internal Wires
    wire [31:0] pc_next;
    wire [31:0] pc;
    wire [31:0] old_pc;
    wire [31:0] instr;
    wire [31:0] data;
    wire [31:0] rd1, rd2;
    wire [31:0] a, b;
    wire [31:0] imm_ext;
    wire [31:0] src_a, src_b;
    wire [31:0] alu_result;
    wire [31:0] alu_out;
    wire [31:0] result;

    // Connect outputs to controller
    assign op        = instr[6:0];
    assign funct3    = instr[14:12];
    assign funct7_5  = instr[30];

    // Connect memory outputs
    assign writedata = b; // Data written to memory comes directly from register B

    // -------------------------------------------------------------
    // 1. Program Counter (PC) Logic
    // -------------------------------------------------------------
    flopenr #(.WIDTH(32)) u_pc_reg (
        .clk   (clk),
        .rst_n (rst_n),
        .en    (pc_write),
        .d     (result),
        .q     (pc)
    );

    // Memory Address MUX (AdrSrc)
    assign adr = (adr_src) ? alu_out : pc;

    // -------------------------------------------------------------
    // 2. Fetch/Decode Pipeline Registers (OldPC, Instr, Data)
    // -------------------------------------------------------------
    flopenr #(.WIDTH(32)) u_old_pc_reg (
        .clk   (clk),
        .rst_n (rst_n),
        .en    (ir_write),
        .d     (pc),
        .q     (old_pc)
    );

    flopenr #(.WIDTH(32)) u_instr_reg (
        .clk   (clk),
        .rst_n (rst_n),
        .en    (ir_write),
        .d     (readdata),
        .q     (instr)
    );

    flopr #(.WIDTH(32)) u_data_reg (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (readdata),
        .q     (data)
    );

    // -------------------------------------------------------------
    // 3. Register File & Sign Extension
    // -------------------------------------------------------------
    reg_file u_reg_file (
        .clk (clk),
        .we3 (reg_write),
        .a1  (instr[19:15]),
        .a2  (instr[24:20]),
        .a3  (instr[11:7]),
        .wd3 (result),
        .rd1 (rd1),
        .rd2 (rd2)
    );

    extend u_extend (
        .instr   (instr[31:7]),
        .imm_src (imm_src),
        .imm_ext (imm_ext)
    );

    // Pipeline Registers for Register File Outputs (A, B)
    flopr #(.WIDTH(32)) u_reg_a (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (rd1),
        .q     (a)
    );

    flopr #(.WIDTH(32)) u_reg_b (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (rd2),
        .q     (b)
    );

    // -------------------------------------------------------------
    // 4. ALU Input Multiplexers (ALUSrcA, ALUSrcB)
    // -------------------------------------------------------------
    mux3 #(.WIDTH(32)) u_mux_src_a (
        .d0 (pc),
        .d1 (old_pc),
        .d2 (a),
        .s  (alu_src_a),
        .y  (src_a)
    );

    mux3 #(.WIDTH(32)) u_mux_src_b (
        .d0 (b),
        .d1 (imm_ext),
        .d2 (32'd4),
        .s  (alu_src_b),
        .y  (src_b)
    );

    // -------------------------------------------------------------
    // 5. ALU & ALUOut Register
    // -------------------------------------------------------------
    alu u_alu (
        .a           (src_a),
        .b           (src_b),
        .alu_control (alu_control),
        .result      (alu_result),
        .zero        (zero)
    );

    flopr #(.WIDTH(32)) u_alu_out_reg (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (alu_result),
        .q     (alu_out)
    );

    // -------------------------------------------------------------
    // 6. Result Multiplexer (ResultSrc)
    // -------------------------------------------------------------
    mux3 #(.WIDTH(32)) u_mux_result (
        .d0 (alu_out),
        .d1 (data),
        .d2 (alu_result),
        .s  (result_src),
        .y  (result)
    );

endmodule