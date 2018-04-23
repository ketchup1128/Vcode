module indexunfold(clk, rst, row_fini,
                   data_in_0, data_in_1, data_in_2, data_in_3, data_in_4, pop_num);
parameter ROW_LENGTH     = 28;
parameter FILTER_SIZE    = 5;
parameter WORD_WIDTH     = 24;
parameter RAM_DEPTH      = ROW_LENGTH - FILTER_SIZE + 1;
parameter FILENAME       = "C:/Users/Administrator/Desktop/DNN/Vcode/data/initialtozero.dat";

input [31:0]data_in_0 ;
input [31:0]data_in_1 ;
input [31:0]data_in_2 ;
input [31:0]data_in_3 ;
input [31:0]data_in_4 ; 
input [2:0]pop_num;
input row_fini;

input clk , rst;

reg [WORD_WIDTH -1:0] mem_unfold [0 : RAM_DEPTH - 1];

always @(posedge clk or posedge rst) begin
    if (rst) begin
       $readmemb(FILENAME, mem_unfold);         
    end
    else begin
        case (pop_num)
        3'd1: mem_unfold[data_in_4[31:24]] <= data_in_4[23:0];
        3'd2: begin 
            mem_unfold[data_in_4[31:24]] <= data_in_4[23:0];
            mem_unfold[data_in_3[31:24]] <= data_in_3[23:0];
        end
        3'd3: begin 
            mem_unfold[data_in_4[31:24]] <= data_in_4[23:0];
            mem_unfold[data_in_3[31:24]] <= data_in_3[23:0];
            mem_unfold[data_in_2[31:24]] <= data_in_2[23:0];
        end
        3'd4: begin 
            mem_unfold[data_in_4[31:24]] <= data_in_4[23:0];
            mem_unfold[data_in_3[31:24]] <= data_in_3[23:0];
            mem_unfold[data_in_2[31:24]] <= data_in_2[23:0];
            mem_unfold[data_in_1[31:24]] <= data_in_1[23:0];
        end
        3'd5: begin 
            mem_unfold[data_in_0[31:24]] <= data_in_0[23:0];
            mem_unfold[data_in_1[31:24]] <= data_in_1[23:0];
            mem_unfold[data_in_2[31:24]] <= data_in_2[23:0];
            mem_unfold[data_in_3[31:24]] <= data_in_3[23:0];
            mem_unfold[data_in_4[31:24]] <= data_in_4[23:0];
        end
        endcase  
    end
end


always @(posedge row_fini)begin
    mem_unfold[data_in_0[31:24]] <= data_in_0[23:0];
    mem_unfold[data_in_1[31:24]] <= data_in_1[23:0];
    mem_unfold[data_in_2[31:24]] <= data_in_2[23:0];
    mem_unfold[data_in_3[31:24]] <= data_in_3[23:0];
    mem_unfold[data_in_4[31:24]] <= data_in_4[23:0];
end

endmodule 

