module adder_32(
    input  [31:0] a,
    input  [31:0] b,
    input         sub_ctrl, //if sub_ctrl = 0 do add,else do sub
    output [31:0] sum,
    output cout //carry_out   
);

    wire [31:0] b_inv;
    wire [32:0] c;

    assign b_inv = b ^ {32{sub_ctrl}};//if sub_ctrl is 0,b_inv is same to b,else b_inv =~b
    //{32{sub_ctrl}} = 1111 1111 1111  1111 1111 1111 1111  1111 or 0000 ...
    assign c[0] = sub_ctrl;//Two's complement; Used for sub
    assign cout = c[32]; //used for overflow

    genvar i;
    generate
        for(i = 0;i<32;i = i +1) begin: fa_loop
            full_adder fa(
                .a (a[i]),
                .b (b_inv[i]),
                .cin (c[i]),
                .sum (sum[i]),
                .cout(c[i+1])
            );
        end
    endgenerate
endmodule