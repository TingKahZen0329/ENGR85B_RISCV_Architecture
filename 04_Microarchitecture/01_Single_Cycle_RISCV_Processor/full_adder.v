module full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);

    //^ (XOR), & (AND), | (OR)
    assign sum  = a ^ b ^ cin;
    //a = 0, b = 0, cin = 0 ,then sum = 0
    //a = 0, b = 0, cin = 1 ,then sum = 1
    //a = 0, b = 1, cin = 0 ,then sum = 1
    //a = 0, b = 1, cin = 1 ,then sum = 0
    //a = 1, b = 0, cin = 0 ,then sum = 1
    //a = 1, b = 0, cin = 1 ,then sum = 0
    //a = 1, b = 1, cin = 0 ,then sum = 0
    //a = 1, b = 1, cin = 1 ,then sum = 1
    //The sum bit at the current position, (a + b + cin) mod 2
    assign cout = (a & b) | (cin & (a ^ b));
    //a = 0, b = 0, cin = 0 ,then cout = 0
    //a = 0, b = 0, cin = 1 ,then cout = 0
    //a = 0, b = 1, cin = 0 ,then cout = 0
    //a = 0, b = 1, cin = 1 ,then cout = 1
    //a = 1, b = 0, cin = 0 ,then cout = 0
    //a = 1, b = 0, cin = 1 ,then cout = 1
    //a = 1, b = 1, cin = 0 ,then cout = 1
    //a = 1, b = 1, cin = 1 ,then cout = 1 
    //// Carry out: generates a carry (1) if 2 or more inputs are 1  


endmodule