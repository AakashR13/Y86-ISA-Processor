module memory_pipelining (
    input clk,

    input [3:0] M_icode,
    input M_cnd,
    input [63:0] M_valE,
    input [63:0] M_valA,
    input [3:0] M_dstE,
    input [3:0] M_dstM,

    output [3:0] m_icode,
    output [63:0] m_valE,
    output [63:0] m_valM,
    output [3:0] m_dstE,
    output [3:0] m_dstM
);
    
    reg [63:0] data_memory [0:1023];

initial 
begin
    genvar i;
    generate
        for (i = 0; i<1024 ; i=i+1) 
        begin
            data_memory[i] = 64'b0;
        end
    endgenerate
end

reg memory_read,memory_write;

always @(*) 
begin
    if (M_icode == 4'b0101 || M_icode == 4'b1001 ||M_icode == 4'b1011) begin
        memory_read <= 1;
        memory_write <= 0;
    end    
    else if (M_icode == 4'b0100 || M_icode == 4'b1000 ||M_icode == 4'b1010) begin
        memory_read <= 0;
        memory_write <= 1;
    end
    else 
    begin
        memory_read <= 0;
        memory_write <= 0;
    end
end

reg mem_addr, mem_error
always @(*) begin
    if (M_icode == 4'b0100|| M_icode == 4'b0101 || M_icode == 4'b1000 || M_icode == 4'b1010) begin
        mem_addr <= M_valE;
    end 
    else if (M_icode == 4'b1001 || M_icode == 4'b1011) begin
        mem_addr <= M_valA;
    end
    else
    begin
       mem_addr <= 1023; 
    end
end

always @(*) 
begin
    if (mem_addr>=0 && mem_addr<1024) begin
        mem_error <= 0;
    end    
    else
    begin
        mem_error <= 1;
    end
end

always @(*) 
begin
    if (mem_error ==0 && memory_read == 1) begin
        m_valM <= data_memory[mem_addr];
    end    
    else
    begin
        m_valM <= 0;
    end 
end

always @(posedge clk) 
begin
    if (mem_error==0 && memory_write==1) begin
        data_memory[mem_addr] <= M_valA;
    end    
    else begin
    end
end
endmodule