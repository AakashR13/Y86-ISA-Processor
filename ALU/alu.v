// `include "./Add/adder.v"
`include "./ALU/and.v"
`include "./ALU/xor.v"
`include "./ALU/sub.v"

module wrapper (
    input [1:0]control,
    input signed [63:0]a,
    input signed [63:0]b,
    output signed [63:0]Out,
    output overflow_bit
);

wire signed [63:0]Out_add;
wire signed [63:0]Out_sub;
wire signed [63:0]Out_and;
wire signed [63:0]Out_exor;
reg signed [63:0]Output;
wire overflow_add;
wire overflow_sub;
reg overflow_dummy;

adder R1 (a,b,Out_add,overflow_add);

subt S1 (a,b,Out_sub,overflow_sub);

and_64b A1 (a,b,Out_and);

xor_64b X1 (a,b,Out_exor);

always @(*) begin
    case (control)
        2'b00: begin
            Output = Out_add;
            overflow_dummy = overflow_add;
        end
    
        2'b01: begin
            Output = Out_sub;
            overflow_dummy = overflow_sub;
        end

        2'b10: begin
            Output = Out_and;
            overflow_dummy = 1'b0;
        end

        2'b11: begin
            Output = Out_exor;
            overflow_dummy = 1'b0;
        end
    endcase    
end

assign Out = Output;
assign overflow_bit = overflow_dummy;
endmodule