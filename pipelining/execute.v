module execute_pipelining (
    input [3:0] E_icode,
    input [3:0] E_ifun,
    input [63:0] E_valC,
    input [63:0] E_valA,
    input [63:0] E_valB,
    input [3:0] E_dstE,
    input [3:0] E_dstM,

    input [3:0] W_stat,
    input [3:0] m_stat,

    output reg [3:0] e_icode,
    output reg e_ConditionBit,
    output reg [63:0] e_valE,
    output reg [63:0] e_valA,
    output reg [3:0] e_dstE,
    output reg [3:0] e_dstM,
    
);

reg zf,
reg sf,
reg of,

initial begin
    zf = 0;
    sf = 0;
    of = 0;
end


reg signed [1:0] control;
reg signed [63:0] a;
reg signed [63:0] b;
wire signed [63:0] ans;
reg signed [63:0] ans_final;
wire overflow;

initial begin
    control = 2'b00;
    a = 64'b0;
    b = 64'b0;
end

wrapper ALU (
    .control(control),
    .a(a),
    .b(b),
    .Out(ans),
    .overflow_bit(overflow)
);

always @(*)
begin
    if (clk==1)
    begin
        //OPq
        if (icode == 4'b0110)
        begin
            if (ifun == 4'b0000) begin //Add
                control = 2'b00;
                a = valA;
                b = valB;
            end

            else if (ifun == 4'b0001) begin //Subtract
                control = 2'b01;
                a = valA;
                b = valB;
            end

            else if (ifun == 4'b0010) begin //And
                control = 2'b10;
                a = valA;
                b = valB;
            end

            else if (ifun == 4'b0011) begin //Xor
                control = 2'b11;
                a = valA;
                b = valB;
            end

            assign ans_final = ans;
            assign valE = ans_final;

            if (ans == 64'b0) 
            begin
                zf = 1;
            end
            else
            begin
                zf = 0;
            end

            if (ans < 64'b0) 
            begin
                sf = 1;
            end
            else
            begin
                sf = 0;
            end

            if ((a<64'b0==b<64'b0)&&(ans<64'b0!=a<64'b0)) 
            begin
                of = 1;
            end
            else 
            begin
                of = 0;
            end
        end 

        //CMOVXX
        else if (icode == 4'b0010)
        begin
            e_ConditionBit = 0;
            if (ifun == 4'b0000) //rrmovq
            begin 
                e_ConditionBit = 1;
            end

            else if (ifun == 4'b0001) //cmovle
            begin
                if (sf^of|zf) 
                begin
                    e_ConditionBit = 1;
                end
            end

            else if (ifun == 4'b0010) //cmovl
            begin
                if (sf^of) 
                begin
                    e_ConditionBit = 1;    
                end    
            end

            else if (ifun == 4'b0011) //cmove
            begin
                if (zf) 
                begin
                    e_ConditionBit = 1;    
                end    
            end

            else if (ifun == 4'b0100) //cmovne
            begin
                if (~zf) 
                begin
                    e_ConditionBit = 1;    
                end    
            end

            else if (ifun == 4'b0101) //cmovge
            begin
                if (~(sf^of)) 
                begin
                    e_ConditionBit = 1;
                end
            end

            else if (ifun == 4'b0110) //cmovg
            begin
                if (~(sf^of)&(~zf))
                begin
                    e_ConditionBit = 1;    
                end
            end
            valE = 64'b0 + valA; 
            
            if (e_ConditionBit == 1'b0) 
            begin
                rB = 4'b1111;    
            end
        end 

        else if (icode == 4'b0011) //irmovq
        begin
            valE = 64'b0 + valC;    
        end    

        else if ((icode == 4'b0100) || (icode == 4'b0101)) //rmmovq or mrmovq
        begin
            valE = valB + valC;
        end

        else if (icode == 4'b1000) //call
        begin
            valE = valB - 64'd8;
        end

        else if (icode == 4'b1001) //ret
        begin
            valE = valB + 64'd8;
        end

        else if (icode == 4'b1010) //pushq
        begin
            valE = valB - 64'd8;
        end

        else if (icode == 4'b1011) //popq 
        begin
            valE = valB + 64'd8;    
        end

        //jxx
        else if (icode == 4'b0111) 
        begin
            if (ifun == 4'b0000) //jmp
            begin
                e_ConditionBit = 1;
            end

            else if (ifun == 4'b0001) //jle
            begin
                if ((sf^of)|zf) 
                begin
                    e_ConditionBit = 1;    
                end
            end

            else if (ifun == 4'b0010) //jl 
            begin
                if (sf^of)
                begin
                    e_ConditionBit = 1;    
                end     
            end

            else if (ifun == 4'b0011) //je
            begin
                if (zf) 
                begin
                    e_ConditionBit = 1;    
                end    
            end

            else if (ifun == 4'b0100) //jne
            begin
                if (~zf) 
                begin
                    e_ConditionBit = 1;    
                end    
            end

            else if (ifun == 4'b0101) //jge
            begin
                if (~(sf^of)) 
                begin
                    e_ConditionBit = 1;    
                end    
            end

            else if (ifun == 4'b0110) //jg
            begin
                if (~(sf^of)&zf) 
                begin
                    e_ConditionBit = 1;    
                end    
            end
        end

    end
end
endmodule



    
endmodule