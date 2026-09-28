// flopenr.v - Flip-flop with Active-Low Asynchronous Reset and Enable
`timescale 1ns / 1ps

module flopenr #(
    parameter WIDTH = 32
)(
    input                  clk,
    input                  rst_n, // Active-low asynchronous reset
    input                  en,    // Clock enable (e.g., PCWrite, IRWrite)
    input      [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= {WIDTH{1'b0}};
        end else if (en) begin
            q <= d;
        end
    end

endmodule