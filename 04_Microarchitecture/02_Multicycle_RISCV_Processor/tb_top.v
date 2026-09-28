// tb_top.v - End-to-End Testbench for Multicycle RISC-V Processor
`timescale 1ns / 1ps

module tb_top;

    reg         clk;
    reg         rst_n;
    wire [31:0] writedata;
    wire [31:0] dataadr;
    wire        memwrite;

    // Instantiate Top System
    top uut (
        .clk       (clk),
        .rst_n     (rst_n),
        .writedata (writedata),
        .dataadr   (dataadr),
        .memwrite  (memwrite)
    );

    // 100MHz clock
    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("top.vcd");
        $dumpvars(0, tb_top);

        clk   = 1'b0;
        rst_n = 1'b0;

        #12;
        rst_n = 1'b1;

        // Monitor writes to memory (e.g. sw instruction)
        $monitor("Time=%0t | PC=0x%h | MemWrite=%b | Addr=0x%h | WriteData=0x%h",
                 $time, uut.u_core.u_datapath.pc, memwrite, dataadr, writedata);

        // Run sufficient cycles for multicycle execution
        #500;

        // Check if sw succeeded (Word index 3, address 12)
        if (uut.u_mem.ram[3] === 32'd7) begin
            $display("\n=============================================");
            $display(" SUCCESS: Multicycle Processor Passed All Tests! ");
            $display(" Mem[12] = %0d (Expected 7)", uut.u_mem.ram[3]);
            $display("=============================================\n");
        end else begin
            $display("\n=============================================");
            $display(" FAILED: Value mismatch in Memory[12]!");
            $display("=============================================\n");
        end

        $finish;
    end

endmodule