
module memory (
    input [3:0] icode,
    input [63:0] valA,
    input [63:0] valP,
    input [63:0] valE,

    output reg [63:0] valM,
    output reg [63:0] mem_array
);

reg [63:0] dummy_mem_array[0:1023];
reg [63:0] dummy_valM;
always @(*) 
begin
    if (icode == 4'b0100) //rmmovq
    begin
        dummy_mem_array[valE] = valA;
    end

    else if (icode == 4'b0101) //mrmovq
    begin
        dummy_valM = dummy_mem_array[valE];    
        valM = dummy_valM;
    end

    else if (icode == 4'b1010) //pushq
    begin
        dummy_mem_array[valE] = valA;
    end

    else if (icode == 4'b1011) //popq
    begin
        dummy_valM = dummy_mem_array[valA];
        valM = dummy_valM;
    end

    else if (icode == 4'b1000) //call
    begin
        dummy_mem_array[valE] = valP;
    end

    else if (icode == 4'b1001) //ret
    begin
        dummy_valM = dummy_mem_array[valA];
        valM = dummy_valM;
    end    
    mem_array = dummy_mem_array[valE];
end    
endmodule