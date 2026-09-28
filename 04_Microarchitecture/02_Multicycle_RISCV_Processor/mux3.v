// mux3.v - Parameterized 3-to-1 Multiplexer
`timescale 1ns / 1ps

module mux3 #(
    parameter WIDTH = 32
)(
    input      [WIDTH-1:0] d0,  // Selector 2'b00
    input      [WIDTH-1:0] d1,  // Selector 2'b01
    input      [WIDTH-1:0] d2,  // Selector 2'b10
    input      [1:0]       s,   // 2-bit select signal
    output reg [WIDTH-1:0] y
);

    always @(*) begin
        case (s)
            2'b00:   y = d0;
            2'b01:   y = d1;
            2'b10:   y = d2;
            default: y = {WIDTH{1'b0}}; // Safe default fallback
        endcase
    end

endmodule