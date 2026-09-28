// alu.v - 32-bit Arithmetic Logic Unit
`timescale 1ns / 1ps

module alu (
    input      [31:0] a,
    input      [31:0] b,
    input      [2:0]  alu_control,
    output reg [31:0] result,
    output            zero
);

    wire [31:0] sum;
    wire [31:0] b_mux;

    // Subtraction logic: a - b = a + (~b + 1)
    assign b_mux = (alu_control[0]) ? ~b : b;
    assign sum   = a + b_mux + alu_control[0];

    always @(*) begin
        case (alu_control)
            3'b000: result = sum;                         // ADD
            3'b001: result = sum;                         // SUB
            3'b010: result = a & b;                       // AND
            3'b011: result = a | b;                       // OR
            3'b101: result = {31'b0, sum[31] ^ (a[31] ^ b[31] ? a[31] : 1'b0)}; // SLT (Signed comparison)
            default: result = 32'h0000_0000;
        endcase
    end

    // Zero flag output for branch evaluation
    assign zero = (result == 32'h0000_0000) ? 1'b1 : 1'b0;

endmodule