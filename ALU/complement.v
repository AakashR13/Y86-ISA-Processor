module complement (
    input signed [63:0]arr,
    output signed [63:0]two_comp
);

generate
    genvar i;
        for (i = 0;i<64 ;i=i+1 ) begin
            not G (two_comp[i],arr[i]);
        end
endgenerate
endmodule
