module Mem_PE(data_in, data_out, addr, clk, rst);

parameter WORD_WIDTH = 16;
parameter ADDR_WIDTH = 4;
parameter RAM_DEPTH  = (1 << ADDR_WIDTH);
parameter FILENAME = "C:/Users/Administrator/Desktop/DNN/Vcode/mem.dat";

input [WORD_WIDTH - 1 : 0]data_in;
input [ADDR_WIDTH - 1 : 0]addr;
input clk, rst;

output[WORD_WIDTH - 1 : 0]data_out;

reg [WORD_WIDTH -1 : 0]data_out;

// reg [1:0]cnt;
reg [WORD_WIDTH -1:0] mem [0 : RAM_DEPTH - 1];
initial begin
    $readmemb(FILENAME, mem);
end


always @(posedge clk or posedge rst) begin
    if (rst) begin        
        data_out <= 0;      
    end
    else begin
        data_out <= mem[addr];
    end

end

endmodule

