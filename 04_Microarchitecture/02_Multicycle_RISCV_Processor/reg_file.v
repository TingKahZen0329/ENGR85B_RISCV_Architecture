// reg_file.v - 32x32-bit Register File with x0 hardwired to 0
`timescale 1ns / 1ps

module reg_file (
    input         clk,
    input         we3, // RegWrite
    input  [4:0]  a1,  // rs1
    input  [4:0]  a2,  // rs2
    input  [4:0]  a3,  // rd
    input  [31:0] wd3, // Write data
    output [31:0] rd1, // Read data 1
    output [31:0] rd2  // Read data 2
);

    reg [31:0] rf [0:31];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            rf[i] = 32'h0000_0000;
        end
    end

    // Synchronous write on positive clock edge (x0 remains 0)
    always @(posedge clk) begin
        if (we3 && (a3 != 5'd0)) begin
            rf[a3] <= wd3;
        end
    end

    // Asynchronous read (x0 is always 0)
    assign rd1 = (a1 == 5'd0) ? 32'h0000_0000 : rf[a1];
    assign rd2 = (a2 == 5'd0) ? 32'h0000_0000 : rf[a2];

endmodule