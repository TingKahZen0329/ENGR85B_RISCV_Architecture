// mux3.v - 3-to-1 Multiplexer (Parameterized Width)
`timescale 1ns / 1ps

module mux3 #(
    parameter WIDTH = 32
)(
    input  [WIDTH-1:0] d0,  // 00: ALUResult
    input  [WIDTH-1:0] d1,  // 01: ReadData
    input  [WIDTH-1:0] d2,  // 10: PCPlus4
    input  [1:0]       s,
    output reg [WIDTH-1:0] y
);

    always @(*) begin
        case (s)
            2'b00:   y = d0;
            2'b01:   y = d1;
            2'b10:   y = d2;
            default: y = {WIDTH{1'b0}};
        endcase
    end

endmodule