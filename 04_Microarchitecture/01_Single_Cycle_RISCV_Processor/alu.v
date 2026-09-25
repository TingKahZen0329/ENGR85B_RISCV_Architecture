module alu(
    input [31:0]  Src_A,
    input [31:0]  Src_B,
    input [2:0]   ALU_Control,
    output [31:0] ALU_Result,
    output Zero
);

wire [31:0] sumResult;
wire        cout;
wire [31:0] andResult;
wire [31:0] orResult;
wire [31:0] sltResult;

//logic operation :& = and/ | = or
assign andResult = Src_A & Src_B;
assign orResult  = Src_A | Src_B;

//add and sum
adder_32 u_adder(
    .a (Src_A),
    .b (Src_B),
    .sub_ctrl (ALU_Control[0]),
    .sum (sumResult),
    .cout (cout)
);
//if A<B then slt = 1 else slt = 0
assign sltResult ={31'b0 , sumResult[31]};

//switch case
reg [31:0] resultMux;
always @(*) begin
    case (ALU_Control)
        3'b000: resultMux = sumResult;
        3'b001: resultMux = sumResult;
        3'b010: resultMux = andResult;
        3'b011: resultMux = orResult;
        3'b101: resultMux = sltResult;
        default: resultMux = 32'b0;
    endcase
end

assign ALU_Result = resultMux;

//used for beq
assign Zero = (resultMux == 0);

endmodule