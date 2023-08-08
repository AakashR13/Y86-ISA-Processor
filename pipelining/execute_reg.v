module decode_reg (
    input clk, 

    input [3:0] d_icode,
    input [3:0] d_ifun,
    input [63:0] d_valC,
    input [63:0] d_valA,
    input [63:0] d_valB,
    input [3:0] d_dstE,
    input [3:0] d_dstM,
    input [3:0] d_srcA,
    input [3:0] d_srcB,

    output reg [3:0] E_icode,
    output reg [3:0] E_ifun,
    output reg [63:0] E_valC,
    output reg [63:0] E_valA,
    output reg [63:0] E_valB,
    output reg [3:0] E_dstE,
    output reg [3:0] E_dstM,
    output reg [3:0] E_srcA,
    output reg [3:0] E_srcB
);

always @(posedge clk) 
begin
    E_icode  <= d_icode
    E_ifun <= d_ifun
    E_valC <= d_valC
    E_valA <= d_valA
    E_valB <= d_valB
    E_dstE <= d_dstE
    E_dstM <= d_dstM
    E_srcA <= d_srcA
    E_srcB <= d_srcB
end
    
endmodule