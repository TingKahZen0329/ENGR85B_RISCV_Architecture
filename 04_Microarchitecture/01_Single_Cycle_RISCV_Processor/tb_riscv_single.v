// tb_riscv_single.v - System-Level Testbench
`timescale 1ns / 1ps

module tb_riscv_single;

    reg clk;
    reg rst_n;

    // Instantiate Device Under Test (DUT)
    riscv_single uut (
        .clk   (clk),
        .rst_n (rst_n)
    );

    // Clock generator: 10ns period (100MHz)
    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("riscv_single.vcd");
        $dumpvars(0, tb_riscv_single);

        clk   = 1'b0;
        rst_n = 1'b0;
        #22;
        rst_n = 1'b1;

        // -------------------------------------------------------------
        // Initialize architectural state to match textbook example:
        // x9 = 0x2004, x5 = 6, DataMemory[0x2000] = 10
        // -------------------------------------------------------------
        uut.u_reg_file.rf[9] = 32'h0000_2004;
        uut.u_reg_file.rf[5] = 32'h0000_0006;

        // 0x2000 >> 2 = 0x800 (word index 2048)
        uut.u_dmem.mem[32'h0000_2000 >> 2] = 32'd10;

        // Monitor critical execution stages
        $monitor("Time=%0t | PC=0x%h | Instr=0x%h | ALURes=0x%h | Zero=%b | RegW=%b Res=0x%h | MemW=%b ReadData=0x%h | PCSrc=%b",
                 $time, uut.pc, uut.instr, uut.alu_result, uut.zero,
                 uut.reg_write, uut.result, uut.mem_write, uut.read_data, uut.pc_src);

        // Hold reset for 20ns
        #20;
        rst_n = 1'b1;

        // Run through the loop cycles
        #120;

        $finish;
    end

endmodule