
`include "./ALU/complement.v"
`include "./ALU/adder.v"

// Version 1
module subt(
    input signed [63:0]a,
  input signed [63:0]b,
  output signed [63:0]out,
  output overflow_bit
  );

wire [63:0]carry;
assign carry = 64'b1;
wire ovf;
wire signed [63:0]b1;
wire signed [63:0]b2;


complement g1(b,b1);
adder g2(b1,carry,b2,ovf);  
adder g3(a,b2,out,overflow_bit);  
endmodule

