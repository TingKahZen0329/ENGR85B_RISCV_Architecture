module reg_file (
    input clk,
    input we3,
    input [4:0] a1, a2, a3,
    input [31:0] wd3,
    output [31:0]rd1,rd2
);

    reg [31:0] rf [31:0];
    always @(posedge clk) begin
        if(we3 && (a3 != 5'b0)) begin
        rf[a3] <= wd3;
        end
    end

    assign rd1 = (a1 == 5'b0) ? 32'b0 : rf[a1];
    assign rd2 = (a2 == 5'b0) ? 32'b0 : rf[a2];
endmodule
//1.clk :Connect clk,and The register file employs edge triggering (typically the rising edge, `posedge clk`),
// and all register updates are completed at the instant of the clock transition.

//2.we3:Write Enable 3:Connect to the RegWrite control signal output by the controller (main control unit).
//When we3 = 1, writing data to the register is enabled on the rising edge of clk.
//When we3 = 0, writing is disabled, and all internal values ​​remain unchanged.

//3.a1,a2,a3 (Address:5bits)
//Since RISC-V has a total of 32 registers (x0 through x31)—requiring 2^5 = 32 addresses—the address width is 5 bits.
//a1 = rs1 Bits 19 to 15 of the instruction (Instr[19:15])
//a2 = rs2 Bits 24 to 20 of the instruction (Instr[24:20])
//a3 = rd  Connect bits 11 through 7 of the instruction (Instr[11:7]).

//4.wd3 :Write Data 3
//The 32-bit actual data to be written to the register.
//Connects to the Result bus from the CPU backend (typically originating from a large MUX).
//For an arithmetic instruction (such as `add`), the input is the result calculated by the ALU (`ALUResult`).
//For a load instruction (such as `lw`), the input is the data read from memory (`ReadData`)—specifically,
// the long feedback path shown in the diagram connecting Data Memory back to `WD3`.

//5.rd1
//Asynchronous combinational logic output. 
//As soon as an address is provided to `a1`, `rd1` immediately outputs the 32-bit value of that register (outputting all zeros if `a1 == 0`).
//Connect directly to the ALU's first input, SrcA.

//6.rd2
//Asynchronous combinational logic output; immediately outputs the value of the register specified by a2.
//Connected to the multiplexer (ALUSrc MUX) preceding the ALU's second input, for use in R-type operations (such as `add` and `sub`).
//Connected to the data write port (WD) of the Data Memory, allowing store instructions (such as `sw`) to write register contents to memory.