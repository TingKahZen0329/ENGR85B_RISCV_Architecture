module dff_pc (
    input             clk,
    input             rst_n,      // Active-low asynchronous reset 
    input      [31:0] pc_next,    // next PC address
    output reg [31:0] pc          // current PC address
);

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc <= 32'h0000_1000;
        end else begin
            pc <= pc_next;        //every cylce pc =pc_next
        end
    end

endmodule


