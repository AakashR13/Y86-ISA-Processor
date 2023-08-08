module PC_update (
    // input clk,
    input condition_bit,
    input [3:0] icode,
    input [63:0] valC,
    input [63:0] valP,
    input [63:0] valM,
    //input [63:0] PC,

    output reg [63:0] final_PC
);

reg [63:0] dummy_PC;
always @(*) 
begin

    if ((icode == 4'b0110) || (icode == 4'b0011) || (icode == 4'b0100) || (icode == 4'b0101) || (icode == 4'b1010) || (icode == 4'b1011)) //OPq | irmovq | rmmovq | mrmovq | pushq | popq
    begin
        dummy_PC = valP;
    end 

    else if (icode == 4'b0001) begin
        dummy_PC = valP;
    end

    else if (icode == 4'b0000) begin        
    end

    else if (icode == 4'b1000) //call
    begin
        dummy_PC = valC;    
    end

    else if (icode == 4'b1001) //ret
    begin
        dummy_PC = valM;    
    end

    else if (icode == 4'b0111) //Jxx
    begin
        if (condition_bit == 1'b1) 
        begin
            dummy_PC = valC;    
        end    
        else
        begin
            dummy_PC = valP;
        end
    end

    else if (icode == 4'b0010) //cmovxx
    begin
        dummy_PC = valP;
    end
    assign final_PC = dummy_PC;
end
    
endmodule