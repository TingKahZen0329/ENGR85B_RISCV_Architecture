// mux2.v - 2-to-1 Multiplexer (Parameterized Width)
module mux2 #(
    parameter WIDTH = 32
)(
    input  [WIDTH-1:0] d0,  
    input  [WIDTH-1:0] d1,  
    input              s,   
    output [WIDTH-1:0] y    
);

    assign y = s ? d1 : d0; //if s =1 then y =d1 else y =d2

endmodule