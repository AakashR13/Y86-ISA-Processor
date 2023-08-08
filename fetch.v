
module fetch(
  clk,PC,
  icode,ifun,rA,rB,valC,valP,instr_val,imem_er,halt
);

  input clk;
  input [63:0] PC;
  
  output reg [3:0] icode;
  output reg [3:0] ifun;
  output reg [3:0] rA;
  output reg [3:0] rB; 
  output reg [63:0] valC;
  output reg [63:0] valP;
  output reg instr_val;
  output reg imem_er;
  output reg halt;

  reg [7:0] instr_mem[0:1023];

  reg [0:79] instr;

  initial begin
  // Instruction memory

   instr_mem[0]=8'b00110000; 
   instr_mem[1]=8'b00000000; 
   instr_mem[2]=8'b00000000;           
   instr_mem[3]=8'b00000000;           
   instr_mem[4]=8'b00000000;           
   instr_mem[5]=8'b00000000;           
   instr_mem[6]=8'b00000000;           
   instr_mem[7]=8'b00000000;           
   instr_mem[8]=8'b00000000;          
   instr_mem[9]=8'b00000000; 
   instr_mem[10]=8'b00110000; 
   instr_mem[11]=8'b00000010; 
   instr_mem[12]=8'b00000000;           
   instr_mem[13]=8'b00000000;           
   instr_mem[14]=8'b00000000;           
   instr_mem[15]=8'b00000000;           
   instr_mem[16]=8'b00000000;           
   instr_mem[17]=8'b00000000;           
   instr_mem[18]=8'b00000000;          
   instr_mem[19]=8'b00010000; 
   instr_mem[20]=8'b00110000; 
   instr_mem[21]=8'b00000011; 
   instr_mem[22]=8'b00000000;           
   instr_mem[23]=8'b00000000;           
   instr_mem[24]=8'b00000000;           
   instr_mem[25]=8'b00000000;           
   instr_mem[26]=8'b00000000;           
   instr_mem[27]=8'b00000000;           
   instr_mem[28]=8'b00000000;          
   instr_mem[29]=8'b00001100; 
   instr_mem[30]=8'b01110000;
   instr_mem[31]=8'b00000000; 
   instr_mem[32]=8'b00100111; 
   instr_mem[33]=8'b00001100; 
   instr_mem[34]=8'b00100111;
   instr_mem[35]=8'b00000011; 
   instr_mem[36]=8'b01110011;
   instr_mem[37]=8'b00100111; 
   instr_mem[38]=8'b00100111;  
   instr_mem[39]=8'b01100000;
   instr_mem[40]=8'b00000011; 
   instr_mem[41]=8'b01110011; 
   instr_mem[42]=8'b01110011; 
   instr_mem[43]=8'b00000011; 
   instr_mem[44]=8'b00110000; 
   instr_mem[45]=8'b01110011; 
   instr_mem[46]=8'b01110000; 
   instr_mem[47]=8'b00000000; 
   instr_mem[48]=8'b00000000; 
   instr_mem[49]=8'b01111010; 
   instr_mem[50]=8'b01100000; 
   instr_mem[51]=8'b00000010; 
   instr_mem[52]=8'b01110011; 
   instr_mem[53]=8'b00000000; 
   instr_mem[54]=8'b00000000; 
   instr_mem[55]=8'b00000000; 
   instr_mem[56]=8'b00000000; 
   instr_mem[57]=8'b00000000; 
   instr_mem[58]=8'b00000000; 
   instr_mem[59]=8'b00000000; 
   instr_mem[60]=8'b01111101; 
   instr_mem[61]=8'b01110000; 
   instr_mem[62]=8'b00000000; 
   instr_mem[63]=8'b00000000; 
   instr_mem[64]=8'b00000000; 
   instr_mem[65]=8'b00000000; 
   instr_mem[66]=8'b00000000; 
   instr_mem[67]=8'b00000000; 
   instr_mem[68]=8'b00000000; 
   instr_mem[69]=8'b01000110;  
   instr_mem[70]=8'b00100000;
   instr_mem[71]=8'b00100110; 
   instr_mem[72]=8'b00100000; 
   instr_mem[73]=8'b00110111; 
   instr_mem[74]=8'b01100001; 
   instr_mem[75]=8'b00110110; 
   instr_mem[76]=8'b01110001; 
   instr_mem[77]=8'b00000000; 
   instr_mem[78]=8'b00000000; 
   instr_mem[79]=8'b00000000; 
   instr_mem[80]=8'b00000000; 
   instr_mem[81]=8'b00000000; 
   instr_mem[82]=8'b00000000;
   instr_mem[83]=8'b00000000; 
   instr_mem[84]=8'b01100000; 
   instr_mem[85]=8'b01100001; 
   instr_mem[86]=8'b00100111; 
   instr_mem[87]=8'b01110001; 
   instr_mem[88]=8'b00000000; 
   instr_mem[89]=8'b00000000; 
   instr_mem[90]=8'b00000000; 
   instr_mem[91]=8'b00000000; 
   instr_mem[92]=8'b00000000; 
   instr_mem[93]=8'b00000000; 
   instr_mem[94]=8'b00000000; 
   instr_mem[95]=8'b01101101; 
   instr_mem[96]=8'b00100000; 
   instr_mem[97]=8'b00110010; 
   instr_mem[98]=8'b00100000; 
   instr_mem[99]=8'b01100011; 
   instr_mem[100]=8'b01110000; 
   instr_mem[101]=8'b00000000; 
   instr_mem[102]=8'b00000000; 
   instr_mem[103]=8'b00000000; 
   instr_mem[104]=8'b00000000; 
   instr_mem[105]=8'b00000000; 
   instr_mem[106]=8'b00000000; 
   instr_mem[107]=8'b00000000; 
   instr_mem[108]=8'b00100111; 
   instr_mem[109]=8'b00100000; 
   instr_mem[110]=8'b00110010; 
   instr_mem[111]=8'b00100000; 
   instr_mem[112]=8'b01110011;
   instr_mem[113]=8'b01110000; 
   instr_mem[114]=8'b00000000;
   instr_mem[115]=8'b00000000;
   instr_mem[116]=8'b00000000;
   instr_mem[117]=8'b00000000;
   instr_mem[118]=8'b00000000; 
   instr_mem[119]=8'b00000000; 
   instr_mem[120]=8'b00000000; 
   instr_mem[121]=8'b00100111; 
   instr_mem[122]=8'b00100000; 
   instr_mem[123]=8'b00100001; 
   instr_mem[124]=8'b00000000;
   instr_mem[125]=8'b00100000; 
   instr_mem[126]=8'b00110001; 
   instr_mem[127]=8'b00000000;
  end  

  always@(posedge clk) 
  begin 

    imem_er=0;
    if(PC>1023)
    begin
      imem_er=1;
    end

    instr={
      instr_mem[PC],
      instr_mem[PC+1],
      instr_mem[PC+2],
      instr_mem[PC+3],
      instr_mem[PC+4],
      instr_mem[PC+5],
      instr_mem[PC+6],
      instr_mem[PC+7],
      instr_mem[PC+8],
      instr_mem[PC+9]
    };

    icode= instr[0:3];
    ifun= instr[4:7];

    instr_val=1'b1;
  case(icode)
    4'd0: //halt
    begin
      halt=1;
      valP=PC+64'd1;
    end
    4'd1: //nop
    begin
      valP=PC+64'd1;
    end
    4'd2://cmovxx
    begin
      rA=instr[8:11];
      rB=instr[12:15];
      valP=PC+64'd2;
    end
    4'd3: //irmovq
    begin
      rA=instr[8:11];
      rB=instr[12:15];
      valC[7:0]=instr[16:23];
      valC[15:8]=instr[24:31];
      valC[23:16]=instr[32:39];
      valC[31:24]=instr[40:47];
      valC[39:32]=instr[48:55];
      valC[47:40]=instr[56:63];
      valC[55:48]=instr[64:71];
      valC[63:56]=instr[72:79];
      valP=PC+64'd10;
    end
    4'd4: //rmmovq
    begin
      rA=instr[8:11];
      rB=instr[12:15];
      valC=instr[16:79];
      valP=PC+64'd10;
    end
    4'd5: //mrmovq
    begin
      rA=instr[8:11];
      rB=instr[12:15];
      valC[7:0]=instr[16:23];
      valC[15:8]=instr[24:31];
      valC[23:16]=instr[32:39];
      valC[31:24]=instr[40:47];
      valC[39:32]=instr[48:55];
      valC[47:40]=instr[56:63];
      valC[55:48]=instr[64:71];
      valC[63:56]=instr[72:79];
      valP=PC+64'd10;
    end
    4'd6: //OPq
    begin
      rA=instr[8:11];
      rB=instr[12:15];
      valP=PC+64'd2;
    end
    4'd7: //jxx
    begin
      valC[7:0]=instr[8:15];
      valC[15:8]=instr[16:23];
      valC[23:16]=instr[24:31];
      valC[31:24]=instr[32:39];
      valC[39:32]=instr[40:47];
      valC[47:40]=instr[48:55];
      valC[55:48]=instr[56:63];
      valC[63:56]=instr[64:71];
      valP=PC+64'd9;
    end
    4'd8: //call
    begin
      valC[7:0]=instr[8:15];
      valC[15:8]=instr[16:23];
      valC[23:16]=instr[24:31];
      valC[31:24]=instr[32:39];
      valC[39:32]=instr[40:47];
      valC[47:40]=instr[48:55];
      valC[55:48]=instr[56:63];
      valC[63:56]=instr[64:71];
      valP=PC+64'd9;
    end
    4'd9: //ret
    begin
      valP=PC+64'd1;
    end
    4'd10: //pushq
    begin
      rA=instr[8:11];
      rB=instr[12:15];
      valP=PC+64'd2;
    end
    4'd11: //popq
    begin
      rA=instr[8:11];
      rB=instr[12:15];
      valP=PC+64'd2;
    end
    default: 
    begin
      instr_val=1'b0;
    end
  endcase
  end

endmodule