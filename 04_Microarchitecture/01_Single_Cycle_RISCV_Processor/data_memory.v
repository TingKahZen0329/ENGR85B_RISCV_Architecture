module data_memory (
    input             clk,
    input             we,       // (Write Enable)
    input      [31:0] addr,     // (from ALU)
    input      [31:0] wd,       // (from Register File RD2)
    output     [31:0] rd        // (to Register File WD3)
);

   

    reg [31:0] mem [0:4095]; 
    integer i;

    initial begin
        for (i = 0; i < 4096; i = i + 1) begin 
            mem[i] = 32'b0;
        end
    end

    //if we == 1 then write the number into memory
    always @(posedge clk) begin
        if (we) begin
            mem[addr[31:2]] <= wd;
        end
    end

    //load the number from the memory
    assign rd = mem[addr[31:2]];

endmodule