module fetch_reg(
  clk,pc,
  f_pc
);  
  input clk;
  input [63:0] pc;
  output reg [63:0] f_pc;

  always@(posedge clk)
  begin
    f_pc<=pc;
  end
endmodule