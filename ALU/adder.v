module full_adder (a,b,c_in,sum,c_out);
    input a,b,c_in;
    output sum,c_out;
    wire w1,w2,w3;

    xor Exor1(w1,a,b);
    xor Exor2(sum,w1,c_in);
    and And1(w2,a,b);
    and And2(w3,w1,c_in);
    or Or1(c_out,w2,w3);
endmodule

module adder (
    input signed [63:0]a_r,
    input signed [63:0]b_r,
    output signed [63:0]sum_r,
    output overflow
);

wire [64:0]carry;
assign carry[0] = 1'b0;

genvar i;
    generate
        for (i=0;i<64;i=i+1)
        begin
            full_adder A1 (a_r[i],b_r[i],carry[i],sum_r[i],carry[i+1]);         
        end
    endgenerate

    xor Exor3 (overflow,carry[63],carry[64]);
endmodule
