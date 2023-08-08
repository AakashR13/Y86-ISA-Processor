
module decode_writeback (
    input [3:0] e_dstE,
    input [63:0] e_valE,
    input [3:0] M_dstE,
    input [63:0] M_valE,
    input [3:0] M_dstM,
    input [63:0] m_valM,
    input [3:0] W_dstM,
    input [63:0] W_valM,
    input [3:0] W_dstE,
    input [63:0] W_valE,

    input [63:0] D_valP,
    input [63:0] D_valC,
    input [3:0] D_rA,
    input [3:0] D_rB,
    input [3:0] D_icode,
    input [63:0] D_ifun,
    // input [2:0] D_stat

    output [3:0] d_icode,
    output [3:0] d_ifun,
    output [63:0] d_valC,
    output [63:0] d_valA,
    output [63:0] d_valB,
    output [3:0] d_dstE,
    output [3:0] d_dstM,
    output [3:0] d_rvalA,
    output [3:0] d_rvalB

    output [63:0] reg_mem0,
    output [63:0] reg_mem1,
    output [63:0] reg_mem2,
    output [63:0] reg_mem3,
    output [63:0] reg_mem4,
    output [63:0] reg_mem5,
    output [63:0] reg_mem6,
    output [63:0] reg_mem7,
    output [63:0] reg_mem8,
    output [63:0] reg_mem9,
    output [63:0] reg_mem10,
    output [63:0] reg_mem11,
    output [63:0] reg_mem12,
    output [63:0] reg_mem13,
    output [63:0] reg_mem14,
);

reg [63:0] dummy_reg_mem [0:14];

initial
begin
    genvar i;
    generate
            for (i = 0; i<15 ; i=i+1) 
            begin
                dummy_reg_mem[i] = 64'b0;    
            end
    endgenerate    
end

always @(posedge clk) 
begin
    case (icode)
        4'b0110: begin //OPq
            d_rvalA = dummy_reg_mem[D_rA];
            d_rvalB = dummy_reg_mem[D_rB];
        end
     
        4'b0100: begin //rmmovq
            d_rvalA = dummy_reg_mem[D_rA];
            d_rvalB = dummy_reg_mem[D_rB];
        end
        
        4'b1011: begin //popq
            d_rvalA = dummy_reg_mem[4];
            d_rvalB = dummy_reg_mem[4];
        end

        4'b0010: begin //cmovxx
            d_rvalA = dummy_reg_mem[D_rA];
            d_rvalB = 64'b0;
        end

        4'b0111: begin //jxx
        end

        4'b1000: begin // call
            d_rvalB = dummy_reg_mem[4];
        end

        4'b1010: begin //pushq
            d_rvalA = dummy_reg_mem[D_rA];
            d_rvalB = dummy_reg_mem[4];
        end

        4'b0011: begin //irmovq
        end

        4'b1001: begin //ret
            d_rvalA = dummy_reg_mem[4];
            d_rvalB = dummy_reg_mem[4];
        end

        4'b0101: begin //mrmovq
            d_rvalB = dummy_reg_mem[D_rB];
        end
    endcase

    reg_mem0 = dummy_reg_mem[0]
    reg_mem1 = dummy_reg_mem[1]
    reg_mem2 = dummy_reg_mem[2]
    reg_mem3 = dummy_reg_mem[3]
    reg_mem4 = dummy_reg_mem[4]
    reg_mem5 = dummy_reg_mem[5]
    reg_mem6 = dummy_reg_mem[6]
    reg_mem7 = dummy_reg_mem[7]
    reg_mem8 = dummy_reg_mem[8]
    reg_mem9 = dummy_reg_mem[9]
    reg_mem10 = dummy_reg_mem[10]
    reg_mem11 = dummy_reg_mem[11]
    reg_mem12 = dummy_reg_mem[12]
    reg_mem13 = dummy_reg_mem[13]
    reg_mem14 = dummy_reg_mem[14]
end

always @(*) begin
   if (D_icode == 4'b0010 || D_icode == 4'b0011 || D_icode == 4'b0110) begin
       d_dstE <= D_rB;
   end 
   else if (D_icode == 4'b1000 || D_icode == 4'b1001 || D_icode == 4'b1010 || D_icode == 4'b1011) begin
       d_dstE <= 4'0100;
   end
   else begin
       d_dstE <= 4'b1111;
   end
end

always @(*) begin
   if (D_icode == 4'b0101 || D_icode == 4'b1011) begin
       d_dstM <= D_rA;
   end 
   else
   begin
       d_dstM <= 4'b1111;
   end
end

always @(*) 
begin
    if (D_icode == 4'b0111 || D_icode == 4'b1000) 
    begin
        d_valA = D_valP;
    end
    else if (D_rA == e_dstE) 
    begin
        d_valA = e_valE;
    end    
    else if (D_rA == M_dstM) 
    begin
        d_valA = m_valM;
    end
    else if (D_rA == M_dstE) 
    begin
        d_valA = M_valE;
    end
    else if (D_rA == W_dstM) 
    begin
        d_valA = W_valM;
    end
    else if (D_rA == W_dstE) 
    begin
        d_valA = W_valE;
    end
    else
    begin
        d_valA = d_rvalA;
    end
end

always @(*) 
begin
    if (D_rB == e_dstE) 
    begin
                d_rvalB = e_valE;
    end    
    else if (D_rB == M_dstM) 
    begin
                d_rvalB = m_valM;
    end
    else if (D_rB == M_dstE) 
    begin
                d_rvalB = M_valE;
    end
    else if (D_rB == W_dstM) 
    begin
                d_rvalB = W_valM;
    end
    else if (D_rB == W_dstE) 
    begin
                d_rvalB = W_valE;
    end
    else
    begin
                d_rvalB = d_rvalA;
    end
end
endmodule

// write back

