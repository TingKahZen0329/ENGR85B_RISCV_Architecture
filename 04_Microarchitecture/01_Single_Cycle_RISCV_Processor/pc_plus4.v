module pc_plus4 (
    input  [31:0] pc,
    output [31:0] pc_plus4
);

    wire cout_unused; 

    
    adder_32 u_adder_32 (
        .a   (pc),
        .b   (32'd4),
        .sub_ctrl (1'b0),
        .sum (pc_plus4),
        .cout(cout_unused)//not used
    );

endmodule