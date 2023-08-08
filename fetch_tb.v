module fetch_tb;
  reg clk;
  reg [63:0] PC;
  
  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire instr_val;
  wire imem_er;
  wire halt;

  fetch fetch(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .instr_val(instr_val),
    .imem_er(imem_er),
    .halt(halt)
  );
  
  initial begin 
    clk=0;
    PC=64'd0;

    #10 clk=~clk;PC=64'd0;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
  end 
  
  initial 
		$monitor("clk=%0d PC=%0d icode=%b ifun=%b rA=%b rB=%b,valC=%b,valP=%0d\n",clk,PC,icode,ifun,rA,rB,valC,valP);
endmodule