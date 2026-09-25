module extend(
    input [31:7] instr,
    input  [1:0]  immsrc,    // 00: I-type, 01: S-type, 10: B-type, 11: J-type
    output reg [31:0] imm_ext
);
    always @(*) begin
        case (immsrc)
            // I-type (lw, addi...)
            //if instr[31] is 1, 20's"1"+instr[31:20] =negatif number
            //if instr[31] is 0, 20's"1"+instr[31:20] =positif number
            2'b00: imm_ext = {{20{instr[31]}}, instr[31:20]};
            
            // S-type (sw...)：The immediate value is split right down the middle: the high bits occupy [31:25] and the low bits occupy [11:7].
            2'b01: imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            
            // B-type (beq...):The immediate values ​​are distributed across [31], [7], [30:25], and [11:8].
            2'b10: imm_ext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
            
            // J-type (jal...)
            2'b11: imm_ext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

            default: imm_ext = 32'b0;
        endcase
    end
endmodule