module Mem_5_out(data_in,addr, clk, rst,
                  data_out_0,  data_out_1,  data_out_2,  data_out_3,  data_out_4 
                );

parameter WORD_WIDTH = 16;
parameter ADDR_WIDTH = 4;
parameter RAM_DEPTH  = (1 << ADDR_WIDTH);
parameter FILENAME = "C:/Users/Administrator/Desktop/DNN/Vcode/mem.dat";

input [WORD_WIDTH - 1 : 0]data_in;
input [ADDR_WIDTH  - 1 : 0]addr;
input clk, rst;

output  [WORD_WIDTH - 1 : 0]data_out_0;
output  [WORD_WIDTH - 1 : 0]data_out_1;
output  [WORD_WIDTH - 1 : 0]data_out_2;
output  [WORD_WIDTH - 1 : 0]data_out_3;
output  [WORD_WIDTH - 1 : 0]data_out_4;

reg  [WORD_WIDTH - 1 : 0]data_out_0;
reg  [WORD_WIDTH - 1 : 0]data_out_1;
reg  [WORD_WIDTH - 1 : 0]data_out_2;
reg  [WORD_WIDTH - 1 : 0]data_out_3;
reg  [WORD_WIDTH - 1 : 0]data_out_4;

reg [WORD_WIDTH -1 : 0]data_out;

// reg [1:0]cnt;
reg [WORD_WIDTH -1:0] mem [0 : RAM_DEPTH - 1];
initial begin
    $readmemb(FILENAME, mem);
end


always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_out_0 <= 0;
        data_out_1 <= 0;
        data_out_2 <= 0;
        data_out_3 <= 0;
        data_out_4 <= 0;     
    end
    else begin
        data_out_0 <= mem[addr];
        data_out_1 <= mem[addr + 3'd1];
        data_out_2 <= mem[addr + 3'd2];
        data_out_3 <= mem[addr + 3'd3];
        data_out_4 <= mem[addr + 3'd4];
    end

end

endmodule

