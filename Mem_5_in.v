module Mem_5_in(data_out, addr, clk, rst, pop_num, row_fini,
                data_in_0,  data_in_1,  data_in_2,  data_in_3,  data_in_4 
                );

parameter WORD_WIDTH = 16;
parameter ADDR_WIDTH = 3;
parameter RAM_DEPTH  = (1 << ADDR_WIDTH);

parameter FILENAME = "C:/Users/Administrator/Desktop/DNN/Vcode/mem.dat";


input  [ADDR_WIDTH - 1 : 0]addr;
input  [WORD_WIDTH - 1 : 0]data_in_0;
input  [WORD_WIDTH - 1 : 0]data_in_1;
input  [WORD_WIDTH - 1 : 0]data_in_2;
input  [WORD_WIDTH - 1 : 0]data_in_3;
input  [WORD_WIDTH - 1 : 0]data_in_4;
input clk, rst;
input [2:0]pop_num;
input row_fini;

output [WORD_WIDTH - 1 : 0]data_out;

reg [WORD_WIDTH -1 : 0]data_out;

reg [WORD_WIDTH -1:0] mem [0 : RAM_DEPTH - 1];

// initial begin
//     $readmemb(FILENAME, mem);
// end


always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_out <= 0;
        // pop_num  <= 0;  
        // addr     <= 0;    
    end
    else if (pop_num == 3'b1) begin
        mem[addr] <= data_in_4; 
    end
    else if (pop_num == 3'd2) begin
        mem[addr] <= data_in_4;
        mem[addr + 3'd1] <= data_in_3;
    end
    else if (pop_num == 3'd3) begin
        mem[addr] <= data_in_4;
        mem[addr + 3'd1] <= data_in_3;
        mem[addr + 3'd2] <= data_in_2;
    end
    else if (pop_num == 3'd4) begin
        mem[addr] <= data_in_4;
        mem[addr + 3'd1] <= data_in_3;
        mem[addr + 3'd2] <= data_in_2;
        mem[addr + 3'd3] <= data_in_1;
    end
    else if (pop_num >= 3'd5) begin
        mem[addr] <= data_in_4;
        mem[addr + 3'd1] <= data_in_3;
        mem[addr + 3'd2] <= data_in_2;
        mem[addr + 3'd3] <= data_in_1;
        mem[addr + 3'd4] <= data_in_0;
    end
    // addr <= addr + pop_num;
end

always @(posedge row_fini)begin
    mem[addr] <= data_in_4;
    mem[addr + 3'd1] <= data_in_3;
    mem[addr + 3'd2] <= data_in_2;
    mem[addr + 3'd3] <= data_in_1;
    mem[addr + 3'd4] <= data_in_0;
end

endmodule


