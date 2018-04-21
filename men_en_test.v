module men_en_test(data_in, data_out, clk, rst);

parameter WORD_WIDTH = 16;
parameter ADDR_WIDTH = 4;
parameter RAM_DEPTH  = (1 << ADDR_WIDTH);
parameter FILENAME = "C:/Users/Administrator/Desktop/DNN/Vcode/data/mem.dat";

input [WORD_WIDTH - 1 : 0]data_in;
input clk, rst;
output[WORD_WIDTH - 1 : 0]data_out;

reg [WORD_WIDTH -1:0] mem [0 : RAM_DEPTH - 1];
reg [WORD_WIDTH -1 : 0]data_out;
reg [3:0]cnt;
// wire Eclk;
wire Rclk;
wire [ADDR_WIDTH - 1 : 0]addr;
reg Mem_EN;

initial $readmemb(FILENAME, mem);

assign Rclk = clk & Mem_EN;
assign addr = cnt;
// assign Mem_EN =(rst==1'b1 ? 1'b1 : ((cnt == 2'd3 || cnt == 3'd4) ? clk ^~ (cnt == 2'd3) : 1'b1)) ;
// assign Rclk = ();


always @(posedge Rclk or posedge rst) begin
// always @(posedge clk or posedge rst) begin
    if (rst) begin        
        data_out <= 0;      
    end
    else begin
        data_out <= mem[addr];
    end

end

always @(posedge clk or posedge rst) begin
// always @(posedge clk or posedge rst) begin
    if (rst) begin        
        cnt <= 0;      
    end
    else begin
        cnt <= cnt +1'b1;
    end
end


always @(negedge clk or posedge rst) begin
// always @(posedge clk or posedge rst) begin
    if (rst) begin        
        Mem_EN <= 1'b1;      
    end
    else if(cnt == 2'd3) begin
        Mem_EN <= 0;
    end
    else begin
        Mem_EN <= 1'b1;
    end
end

endmodule
