// controller.v - Top-level Control Unit for Multicycle RISC-V Processor
`timescale 1ns / 1ps

module controller (
    input            clk,
    input            rst_n,
    // Instructions field inputs
    input      [6:0] op,
    input      [2:0] funct3,
    input            funct7_5,
    // Status flag input
    input            zero,
    // Control outputs to Datapath and Memory
    output           pc_write,
    output           adr_src,
    output           mem_write,
    output           ir_write,
    output     [1:0] result_src,
    output     [2:0] alu_control,
    output     [1:0] alu_src_a,
    output     [1:0] alu_src_b,
    output     [1:0] imm_src,
    output           reg_write
);

    // Internal interconnection wires
    wire       pc_update;
    wire       branch;
    wire [1:0] alu_op;

    // 1. PC Write Enable Logic: Update either unconditionally or when branch is taken
    assign pc_write = pc_update | (branch & zero);

    // 2. Main FSM Instance: Controls sequencing, enables, and MUX select signals
    main_fsm u_main_fsm (
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

    // 3. ALU Decoder Combinational Logic
    // Decodes alu_op, funct3, and funct7_5 into 3-bit alu_control
    reg [2:0] alu_control_reg;
    assign alu_control = alu_control_reg;

    always @(*) begin
        case (alu_op)
            2'b00: alu_control_reg = 3'b000; // Addition (PC+4, memory address, branch target)
            2'b01: alu_control_reg = 3'b001; // Subtraction (beq comparison)
            2'b10: begin                    // R-type or I-type ALU
                case (funct3)
                    3'b000: begin
                        // For R-type: funct7_5 = 1 indicates SUB; for addi: funct7_5 is 0
                        if (op[5] && funct7_5)
                            alu_control_reg = 3'b001; // Subtraction (sub)
                        else
                            alu_control_reg = 3'b000; // Addition (add, addi)
                    end
                    3'b010:  alu_control_reg = 3'b101; // Set Less Than (slt, slti)
                    3'b110:  alu_control_reg = 3'b011; // Bitwise OR (or, ori)
                    3'b111:  alu_control_reg = 3'b010; // Bitwise AND (and, andi)
                    default: alu_control_reg = 3'b000;
                endcase
            end
            default: alu_control_reg = 3'b000;
        endcase
    end

    // 4. Instruction Decoder Combinational Logic (ImmSrc)
    // Decodes opcode to determine immediate extension format
    reg [1:0] imm_src_reg;
    assign imm_src = imm_src_reg;

    always @(*) begin
        case (op)
            7'b0000011: imm_src_reg = 2'b00; // I-type load (lw)
            7'b0010011: imm_src_reg = 2'b00; // I-type ALU (addi)
            7'b0100011: imm_src_reg = 2'b01; // S-type store (sw)
            7'b1100011: imm_src_reg = 2'b10; // B-type branch (beq)
            7'b1101111: imm_src_reg = 2'b11; // J-type jump (jal)
            default:    imm_src_reg = 2'b00;
        endcase
    end

endmodule