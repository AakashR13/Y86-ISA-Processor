module decode (
    input clk,
    input [3:0] icode,
    input [3:0] rA,
    input [3:0] rB,
    
    output reg [63:0] valA,
    output reg [63:0] valB,

    output reg [63:0] valE,
    output reg [63:0] valM,

    output reg [63:0] reg_arr0,
    output reg [63:0] reg_arr1,
    output reg [63:0] reg_arr2,
    output reg [63:0] reg_arr3,
    output reg [63:0] reg_arr4,
    output reg [63:0] reg_arr5,
    output reg [63:0] reg_arr6,
    output reg [63:0] reg_arr7,
    output reg [63:0] reg_arr8,
    output reg [63:0] reg_arr9,
    output reg [63:0] reg_arr10,
    output reg [63:0] reg_arr11,
    output reg [63:0] reg_arr12,
    output reg [63:0] reg_arr13,
    output reg [63:0] reg_arr14
);

reg [63:0] dummy_reg_arr[0:14];
integer i;

initial begin
for (i = 0; i<15; i=i+1) begin
    dummy_reg_arr[i] = 64'd0;
end
end

always @(*) 
begin
    case (icode)
        4'b0000: begin //halt
        end

        4'b0001: begin //nop 
        end

        4'b0110: begin //OPq
            valA = dummy_reg_arr[rA];
            valB = dummy_reg_arr[rB];
        end
     
        4'b0100: begin //rmmovq
            valA = dummy_reg_arr[rA];
            valB = dummy_reg_arr[rB];
        end
        
        4'b1011: begin //popq
            valA = dummy_reg_arr[4];
            valB = dummy_reg_arr[4];
        end

        4'b0010: begin //cmovxx
            valA = dummy_reg_arr[rA];
            valB = 64'b0;
        end

        4'b0111: begin //jxx
        end

        4'b1000: begin // call
            valB = dummy_reg_arr[4];
        end

        4'b1010: begin //pushq
            valA = dummy_reg_arr[rA];
            valB = dummy_reg_arr[4];
        end

        4'b0011: begin //irmovq
        end

        4'b1001: begin //ret
            valA = dummy_reg_arr[4];
            valB = dummy_reg_arr[4];
        end

        4'b0101: begin //mrmovq
            valB = dummy_reg_arr[rB];
        end
    endcase
    reg_arr0 = dummy_reg_arr[0];
    reg_arr1 = dummy_reg_arr[1];
    reg_arr2 = dummy_reg_arr[2];
    reg_arr3 = dummy_reg_arr[3];
    reg_arr4 = dummy_reg_arr[4];
    reg_arr5 = dummy_reg_arr[5];
    reg_arr6 = dummy_reg_arr[6];
    reg_arr7 = dummy_reg_arr[7];
    reg_arr8 = dummy_reg_arr[8];
    reg_arr9 = dummy_reg_arr[9];
    reg_arr10 = dummy_reg_arr[10];
    reg_arr11 = dummy_reg_arr[11];
    reg_arr12 = dummy_reg_arr[12];
    reg_arr13 = dummy_reg_arr[13];
    reg_arr14 = dummy_reg_arr[14]; 
end
    
// Write back
always @(negedge clk) 
begin
    if ((icode == 4'b0010) || (icode == 4'b0011) || (icode == 4'b0110)) //cmovxx | irmovq | OPq
    begin
        dummy_reg_arr[rB] = valE;    
    end    

    else if ((icode == 4'b0101)) //mrmovq
    begin
        dummy_reg_arr[rA] = valM;
    end

    else if ((icode == 4'b1000) || (icode == 4'b1001)) //call
    begin
        dummy_reg_arr[4] = valE; //the 5th register (index 4) is the stack pointer %rsp
    end

    else if (icode == 4'b1010) //pushq
    begin
        dummy_reg_arr[4] = valE;
    end

    else if (icode == 4'b1011) //popq
    begin
        dummy_reg_arr[4] = valE;
        dummy_reg_arr[rA] = valM;    
    end
    reg_arr0 = dummy_reg_arr[0];
    reg_arr1 = dummy_reg_arr[1];
    reg_arr2 = dummy_reg_arr[2];
    reg_arr3 = dummy_reg_arr[3];
    reg_arr4 = dummy_reg_arr[4];
    reg_arr5 = dummy_reg_arr[5];
    reg_arr6 = dummy_reg_arr[6];
    reg_arr7 = dummy_reg_arr[7];
    reg_arr8 = dummy_reg_arr[8];
    reg_arr9 = dummy_reg_arr[9];
    reg_arr10 = dummy_reg_arr[10];
    reg_arr11 = dummy_reg_arr[11];
    reg_arr12 = dummy_reg_arr[12];
    reg_arr13 = dummy_reg_arr[13];
    reg_arr14 = dummy_reg_arr[14]; 
end

endmodule