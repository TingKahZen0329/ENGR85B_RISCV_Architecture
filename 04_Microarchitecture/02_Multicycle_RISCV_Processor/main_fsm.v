// main_fsm.v - Main Finite State Machine for Multicycle RISC-V Processor
`timescale 1ns / 1ps

module main_fsm (
    input            clk,
    input            rst_n,
    input      [6:0] op,
    output reg       pc_update,
    output reg       branch,
    output reg       reg_write,
    output reg       mem_write,
    output reg       ir_write,
    output reg       adr_src,
    output reg [1:0] result_src,
    output reg [1:0] alu_src_a,
    output reg [1:0] alu_src_b,
    output reg [1:0] alu_op
);

    // State Encoding Definitions
    localparam S0_FETCH     = 4'd0;
    localparam S1_DECODE    = 4'd1;
    localparam S2_MEMADR    = 4'd2;
    localparam S3_MEMREAD   = 4'd3;
    localparam S4_MEMWB     = 4'd4;
    localparam S5_MEMWRITE  = 4'd5;
    localparam S6_EXECUTER  = 4'd6;
    localparam S7_ALUWB     = 4'd7;
    localparam S8_EXECUTEI  = 4'd8;
    localparam S9_JAL       = 4'd9;
    localparam S10_BEQ      = 4'd10;

    // RV32I Core Opcode Definitions
    localparam OP_LW        = 7'b0000011;
    localparam OP_SW        = 7'b0100011;
    localparam OP_RTYPE     = 7'b0110011;
    localparam OP_ITYPE     = 7'b0010011; // addi, etc.
    localparam OP_BEQ       = 7'b1100011;
    localparam OP_JAL       = 7'b1101111;

    reg [3:0] current_state, next_state;

    // 1. State Register Sequential Logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= S0_FETCH;
        end else begin
            current_state <= next_state;
        end
    end

    // 2. Next-State Combinational Logic
    always @(*) begin
        case (current_state)
            S0_FETCH:  next_state = S1_DECODE;

            S1_DECODE: begin
                case (op)
                    OP_LW:    next_state = S2_MEMADR;
                    OP_SW:    next_state = S2_MEMADR;
                    OP_RTYPE: next_state = S6_EXECUTER;
                    OP_ITYPE: next_state = S8_EXECUTEI;
                    OP_BEQ:   next_state = S10_BEQ;
                    OP_JAL:   next_state = S9_JAL;
                    default:  next_state = S0_FETCH;
                endcase
            end

            S2_MEMADR: begin
                if (op == OP_LW)
                    next_state = S3_MEMREAD;
                else
                    next_state = S5_MEMWRITE;
            end

            S3_MEMREAD:  next_state = S4_MEMWB;
            S4_MEMWB:    next_state = S0_FETCH;
            S5_MEMWRITE: next_state = S0_FETCH;

            S6_EXECUTER: next_state = S7_ALUWB;
            S8_EXECUTEI: next_state = S7_ALUWB;
            S7_ALUWB:    next_state = S0_FETCH;

            S9_JAL:      next_state = S7_ALUWB;
            S10_BEQ:     next_state = S0_FETCH;

            default:     next_state = S0_FETCH;
        endcase
    end

    // 3. Output Control Signals Combinational Logic
    always @(*) begin
        // Default assignments to prevent unintended latch inference
        pc_update  = 1'b0;
        branch     = 1'b0;
        reg_write  = 1'b0;
        mem_write  = 1'b0;
        ir_write   = 1'b0;
        adr_src    = 1'b0;
        result_src = 2'b00;
        alu_src_a  = 2'b00;
        alu_src_b  = 2'b00;
        alu_op     = 2'b00;

        case (current_state)
            S0_FETCH: begin
                adr_src    = 1'b0; // Route PC to memory address
                ir_write   = 1'b1; // Latch instruction and snapshot OldPC
                alu_src_a  = 2'b00; // ALU Input A selects PC
                alu_src_b  = 2'b10; // ALU Input B selects constant 4
                alu_op     = 2'b00; // Addition operation
                result_src = 2'b10; // Select ALUResult (PC + 4)
                pc_update  = 1'b1; // Update PC register
            end

            S1_DECODE: begin
                alu_src_a  = 2'b01; // ALU Input A selects OldPC
                alu_src_b  = 2'b01; // ALU Input B selects ImmExt
                alu_op     = 2'b00; // Precompute target branch address (OldPC + imm)
            end

            S2_MEMADR: begin
                alu_src_a  = 2'b10; // ALU Input A selects Register A (rs1)
                alu_src_b  = 2'b01; // ALU Input B selects ImmExt
                alu_op     = 2'b00; // Compute effective memory address (rs1 + imm)
            end

            S3_MEMREAD: begin
                result_src = 2'b00;
                adr_src    = 1'b1; // Route ALUOut to memory address
            end

            S4_MEMWB: begin
                result_src = 2'b01; // Select Data register output
                reg_write  = 1'b1; // Write back to register rd
            end

            S5_MEMWRITE: begin
                result_src = 2'b00;
                adr_src    = 1'b1; // Route ALUOut to memory address
                mem_write  = 1'b1; // Assert memory write enable
            end

            S6_EXECUTER: begin
                alu_src_a  = 2'b10; // ALU Input A selects Register A (rs1)
                alu_src_b  = 2'b00; // ALU Input B selects Register B (rs2)
                alu_op     = 2'b10; // Forward operation decoding to ALU Decoder
            end

            S7_ALUWB: begin
                result_src = 2'b00; // Select ALUOut register
                reg_write  = 1'b1; // Write back to register rd
            end

            S8_EXECUTEI: begin
                alu_src_a  = 2'b10; // ALU Input A selects Register A (rs1)
                alu_src_b  = 2'b01; // ALU Input B selects ImmExt
                alu_op     = 2'b10; // Forward operation decoding to ALU Decoder
            end

            S9_JAL: begin
                alu_src_a  = 2'b01; // ALU Input A selects OldPC
                alu_src_b  = 2'b10; // ALU Input B selects constant 4
                alu_op     = 2'b00; // Compute link address (OldPC + 4)
                result_src = 2'b00; // Select branch target address from S1 (ALUOut)
                pc_update  = 1'b1; // Update PC with jump target
            end

            S10_BEQ: begin
                alu_src_a  = 2'b10; // ALU Input A selects Register A (rs1)
                alu_src_b  = 2'b00; // ALU Input B selects Register B (rs2)
                alu_op     = 2'b01; // Subtract to test equality
                result_src = 2'b00; // Select precomputed target address from S1 (ALUOut)
                branch     = 1'b1; // Enable conditional branch (PCWrite = Branch & Zero)
            end
        endcase
    end

endmodule