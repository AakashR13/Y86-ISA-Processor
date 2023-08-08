`include "fetch.v"

module decode_tb;
    reg clk;
  reg [63:0] PC;
  reg [63:0] reg_mem[0:14];

  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire [63:0] valA;
  wire [63:0] valB;
  wire [63:0] valE;
  wire [63:0] valM;

  // trial
  wire [63:0] reg_arr0;
  wire [63:0] reg_arr1;
  wire [63:0] reg_arr2;
  wire [63:0] reg_arr3;
  wire [63:0] reg_arr4;
  wire [63:0] reg_arr5;
  wire [63:0] reg_arr6;
  wire [63:0] reg_arr7;
  wire [63:0] reg_arr8;
  wire [63:0] reg_arr9;
  wire [63:0] reg_arr10;
  wire [63:0] reg_arr11;
  wire [63:0] reg_arr12;
  wire [63:0] reg_arr13;
  wire [63:0] reg_arr14;

    fetch fetch(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP)
  );

    // decode decode(
    //     .clk(clk),
    //     .icode(icode),
    //     .rA(rA),
    //     .rB(rB),
    //     .mem_regA(reg_mem[rA]),
    //     .mem_regB(reg_mem[rB]),
    //     .stack_ptr(reg_mem[4]),
    //     .valA(valA),
    //     .valB(valB)
    // );

    decode decode(
        .clk(clk),
        .icode(icode),
        .rA(rA),
        .rB(rB),
        .valA(valA),
        .valB(valB),
        .valE(valE),
        .valM(valM),
        .reg_arr0(reg_arr0),
        .reg_arr1(reg_arr1),
        .reg_arr2(reg_arr2),
        .reg_arr3(reg_arr3),
        .reg_arr4(reg_arr4),
        .reg_arr5(reg_arr5),
        .reg_arr6(reg_arr6),
        .reg_arr7(reg_arr7),
        .reg_arr8(reg_arr8),
        .reg_arr9(reg_arr9),
        .reg_arr10(reg_arr10),
        .reg_arr11(reg_arr11),
        .reg_arr12(reg_arr12),
        .reg_arr13(reg_arr13),
        .reg_arr14(reg_arr14)
    );


    initial begin

    reg_mem[0]=64'd0;
    reg_mem[1]=64'd1;
    reg_mem[2]=64'd2;
    reg_mem[3]=64'd3;
    reg_mem[4]=64'd4;
    reg_mem[5]=64'd5;
    reg_mem[6]=64'd6;
    reg_mem[7]=64'd7;
    reg_mem[8]=64'd8;
    reg_mem[9]=64'd9;
    reg_mem[10]=64'd10;
    reg_mem[11]=64'd11;
    reg_mem[12]=64'd12;
    reg_mem[13]=64'd13;
    reg_mem[14]=64'd14;

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
    #10 clk=~clk;
  end 
  
  initial 
		$monitor("clk=%0d PC=%0d icode=%b ifun=%b rA=%b rB=%b valA=%0d valB=%0d valE=%0d valM=%0d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valE,valM);
endmodule