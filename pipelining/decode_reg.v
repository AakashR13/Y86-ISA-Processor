module decode_reg (
    input clk;

    input [3:0] f_icode,
    input [3:0] f_ifun,
    input [3:0] f_rA,
    input [3:0] f_rB,
    input [63:0] f_valC,
    input [63:0] f_valP,

    output [3:0]  D_icode,
    output [3:0]  D_ifun,
    output [3:0]  D_rA,
    output [3:0]  D_rB,
    output [63:0] D_valC,
    output [63:0] D_valP, 
);
    
always @(posedge clk) 
begin
    D_icode <= f_icode; 
    D_ifun <= f_ifun;
    D_rA  <= f_rA;
    D_rB <= f_rB;
    D_valC <= f_valC;
    D_valP  <= f_valP; 
end
endmodule