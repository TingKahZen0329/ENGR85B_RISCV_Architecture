// controller.v - Main Control Unit and ALU Decoder with addi & jal support
`timescale 1ns / 1ps

module controller (
    input  [6:0] op,
    input  [2:0] funct3,
    input        funct7_5,     // instr[30]
    input        zero,
    output [1:0] result_src,   // Upgraded to 2-bit
    output       mem_write,
    output       pc_src,
    output       alu_src,
    output [1:0] imm_src,
    output       reg_write,
    output [2:0] alu_control
);

    reg       branch;
    reg       jump;            // New jump signal for jal
    reg       reg_write_reg;
    reg [1:0] imm_src_reg;
    reg       alu_src_reg;
    reg       mem_write_reg;
    reg [1:0] result_src_reg;  // 2-bit
    reg [1:0] alu_op;
    reg [2:0] alu_control_reg;

    // -------------------------------------------------------------
    // Main Decoder: Decodes Opcode (op[6:0])
    // -------------------------------------------------------------
    always @(*) begin
        case (op)
            // lw (Load Word) - I-type
            7'b0000011: begin
                reg_write_reg  = 1'b1;
                imm_src_reg    = 2'b00;
                alu_src_reg    = 1'b1;
                mem_write_reg  = 1'b0;
                result_src_reg = 2'b01; // 01: ReadData from Data Memory
                branch         = 1'b0;
                jump           = 1'b0;
                alu_op         = 2'b00;
            end

            // sw (Store Word) - S-type
            7'b0100011: begin
                reg_write_reg  = 1'b0;
                imm_src_reg    = 2'b01;
                alu_src_reg    = 1'b1;
                mem_write_reg  = 1'b1;
                result_src_reg = 2'b00; // Don't care
                branch         = 1'b0;
                jump           = 1'b0;
                alu_op         = 2'b00;
            end

            // R-type (add, sub, or, and, slt)
            7'b0110011: begin
                reg_write_reg  = 1'b1;
                imm_src_reg    = 2'b00; // Don't care
                alu_src_reg    = 1'b0;
                mem_write_reg  = 1'b0;
                result_src_reg = 2'b00; // 00: ALUResult
                branch         = 1'b0;
                jump           = 1'b0;
                alu_op         = 2'b10;
            end

            // I-type ALU (addi, andi, ori, slti)
            7'b0010011: begin
                reg_write_reg  = 1'b1;
                imm_src_reg    = 2'b00; // 00: I-type imm
                alu_src_reg    = 1'b1;  // Select ImmExt for SrcB
                mem_write_reg  = 1'b0;
                result_src_reg = 2'b00; // 00: ALUResult
                branch         = 1'b0;
                jump           = 1'b0;
                alu_op         = 2'b10; // Let ALU Decoder inspect funct3
            end

            // beq (Branch if Equal) - B-type
            7'b1100011: begin
                reg_write_reg  = 1'b0;
                imm_src_reg    = 2'b10;
                alu_src_reg    = 1'b0;
                mem_write_reg  = 1'b0;
                result_src_reg = 2'b00; // Don't care
                branch         = 1'b1;
                jump           = 1'b0;
                alu_op         = 2'b01;
            end

            // jal (Jump and Link) - J-type
            7'b1101111: begin
                reg_write_reg  = 1'b1;  // Write PC+4 to rd
                imm_src_reg    = 2'b11; // 11: J-type imm
                alu_src_reg    = 1'b0;  // Don't care
                mem_write_reg  = 1'b0;
                result_src_reg = 2'b10; // 10: PCPlus4 to rd
                branch         = 1'b0;
                jump           = 1'b1;  // Unconditional Jump
                alu_op         = 2'b00; // Don't care
            end

            default: begin
                reg_write_reg  = 1'b0;
                imm_src_reg    = 2'b00;
                alu_src_reg    = 1'b0;
                mem_write_reg  = 1'b0;
                result_src_reg = 2'b00;
                branch         = 1'b0;
                jump           = 1'b0;
                alu_op         = 2'b00;
            end
        endcase
    end

    // -------------------------------------------------------------
    // ALU Decoder: Decodes ALUOp, funct3, and funct7_5 / op_5
    // -------------------------------------------------------------
    always @(*) begin
        case (alu_op)
            2'b00: alu_control_reg = 3'b000; // Addition (lw/sw address calculation)
            2'b01: alu_control_reg = 3'b001; // Subtraction (beq comparison)
            2'b10: begin                    // R-type and I-type ALU
                case (funct3)
                    3'b000: begin
                        // For addi (op[5]==0), sub doesn't exist; only R-type uses funct7_5 to select sub
                        if (funct7_5 && op[5])
                            alu_control_reg = 3'b001; // sub
                        else
                            alu_control_reg = 3'b000; // add / addi
                    end
                    3'b010: alu_control_reg = 3'b101; // slt / slti
                    3'b110: alu_control_reg = 3'b011; // or / ori
                    3'b111: alu_control_reg = 3'b010; // and / andi
                    default: alu_control_reg = 3'b000;
                endcase
            end
            default: alu_control_reg = 3'b000;
        endcase
    end

    assign reg_write   = reg_write_reg;
    assign imm_src     = imm_src_reg;
    assign alu_src     = alu_src_reg;
    assign mem_write   = mem_write_reg;
    assign result_src  = result_src_reg;
    assign alu_control = alu_control_reg;
    assign pc_src      = (branch & zero) | jump; // Upgraded branch & jump equation

endmodule