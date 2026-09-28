// flopr.v - Flip-Flop with Active-Low Asynchronous Reset
`timescale 1ns / 1ps

module flopr #(
    parameter WIDTH = 32
)(
    input                  clk,
    input                  rst_n, // Active-low asynchronous reset
    input      [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= {WIDTH{1'b0}};
        end else begin
            q <= d;
        end
    end

endmodule