`include "fetch.v"
`include "execute.v"
`include "decode.v"
`include "write_back.v"
`include "memory.v"
`include "PC_update.v"

module processor;
  reg clk = 0;
  
  reg [63:0] PC;

  reg stat[0:2];

  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire instr_val;
  wire imem_er;
  wire [63:0] valA;
  wire [63:0] valB;
  wire [63:0] valE;
  wire [63:0] valM;
  wire cnd;
  wire hltins;
  wire [63:0] updated_pc;

  // wire [63:0] reg_mem0;
  // wire [63:0] reg_mem1;
  // wire [63:0] reg_mem2;
  // wire [63:0] reg_mem3;
  // wire [63:0] reg_mem4;
  // wire [63:0] reg_mem5;
  // wire [63:0] reg_mem6;
  // wire [63:0] reg_mem7;
  // wire [63:0] reg_mem8;
  // wire [63:0] reg_mem9;
  // wire [63:0] reg_mem10;
  // wire [63:0] reg_mem11;
  // wire [63:0] reg_mem12;
  // wire [63:0] reg_mem13;
  // wire [63:0] reg_mem14;
  wire [63:0] reg_mem[0:14];
  wire [63:0] datamem;

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

  wire sf;
  wire zf;
  wire of;

  fetch fetch(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .instr_val(instr_valid),
    .imem_er(imem_error),
    .halt(hltins)
  );

  execute execute(
    .clk(clk),
    .icode(icode),
    .ifun(ifun),
    .valA(valA),
    .valB(valB),
    .valC(valC),
    .valE(valE),
    .sf(sf),
    .zf(zf),
    .of(of),
    .condition_bit(cnd)
  );

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
  // write_back write_back(
  //       .clk(clk),
  //       .icode(icode),
  //       .rA(rA),
  //       .rB(rB),
  //       .valE(valE),
  //       .valM(valM)
  //   );

  memory memory(
    .icode(icode),
    .valA(valA),
    .valE(valE),
    .valP(valP),
    .valM(valM),
    .mem_array(datamem)
  );

  PC_update PC_update(
    // .clk(clk),
    // .PC(PC),
    .icode(icode),
    .condition_bit(cnd),
    .valC(valC),
    .valM(valM),
    .valP(valP),
    .final_PC(updated_pc)
  ); 

  always #5 clk=~clk;


  initial begin
    $dumpfile("processor.vcd");
    $dumpvars(0,processor);
    stat[0]=1;
    stat[1]=0;
    stat[2]=0;
    clk=0;
    PC=64'd32;
  end 

  always@(*)
  begin
    PC=updated_pc;
  end

  always@(*)
  begin
    if(hltins)
    begin
      stat[2]=hltins;
      stat[1]=1'b0;
      stat[0]=1'b0;
    end
    else if(instr_val)
    begin
      stat[1]=instr_val;
      stat[2]=1'b0;
      stat[0]=1'b0;
    end
    else
    begin
      stat[0]=1'b1;
      stat[1]=1'b0;
      stat[2]=1'b0;
    end
  end
  
  always@(*)
  begin
    if(stat[2]==1'b1)
    begin
      $finish;
    end
  end

  initial 
  begin
    $monitor($time , " clk=%0d PC=%0d icode=%b ifun=%b rA=%d rB=%d valA=%0d valB=%0d valC=%0d valE=%0d valM=%0d\n insval=%0d memerr=%0d cnd=%0d halt=%0d\n 0=%0d 1=%0d 2=%0d 3=%0d 4=%0d 5=%0d 6=%0d 7=%0d 8=%0d 9=%0d 10=%0d 11=%0d 12=%0d 13=%0d 14=%0d datamem=%0d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valC,valE,valM,instr_val,imem_er,cnd,stat[2],reg_mem[0],reg_mem[1],reg_mem[2],reg_mem[3],reg_mem[4],reg_mem[5],reg_mem[6],reg_mem[7],reg_mem[8],reg_mem[9],reg_mem[10],reg_mem[11],reg_mem[12],reg_mem[13],reg_mem[14],datamem);
  end
		
endmodule