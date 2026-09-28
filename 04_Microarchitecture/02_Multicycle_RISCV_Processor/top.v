// top.v - System Top-level containing Core and Unified Memory
`timescale 1ns / 1ps

module top (
    input         clk,
    input         rst_n,
    output [31:0] writedata,
    output [31:0] dataadr,
    output        memwrite
);

    wire [31:0] readdata;

    // CPU Core Instance
    riscv_multicycle u_core (
        .clk       (clk),
        .rst_n     (rst_n),
        .readdata  (readdata),
        .mem_write (memwrite),
        .adr       (dataadr),
        .writedata (writedata)
    );

    // Unified Memory Instance (8KB)
    mem u_mem (
        .clk  (clk),
        .we   (memwrite),
        .addr (dataadr),
        .wd   (writedata),
        .rd   (readdata)
    );

endmodule