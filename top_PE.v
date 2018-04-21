module top_PE(clk, rst, pop_out);
input clk, rst;
output [2:0]pop_out;
parameter row_length     = 28;
parameter filter_size    = 5;

parameter WORD_WIDTH_IN    = 16;
parameter ADDR_WIDTH_IN    = 4;
parameter RAM_DEPTH_IN     = (1 << ADDR_WIDTH_IN);
parameter FILENAME_IN      = "C:/Users/Administrator/Desktop/DNN/Vcode/data/mem.dat";

parameter WORD_WIDTH_W     = 16;
parameter ADDR_WIDTH_W     = 4;
parameter RAM_DEPTH_W      = (1 << ADDR_WIDTH_W);
parameter FILENAME_W       = "C:/Users/Administrator/Desktop/DNN/Vcode/data/mem_weight.dat";
 
parameter WORD_WIDTH_O     = 32;
parameter ADDR_WIDTH_O     = 5;
parameter RAM_DEPTH_O      = (1 << ADDR_WIDTH_O);
parameter FILENAME_O       = "C:/Users/Administrator/Desktop/DNN/Vcode/data/mem_out.dat";

wire [15:0]input_fm;
reg  [4:0]cnt_mem_in;
wire [4:0]cnt_mem_in_wire;

wire [15:0]filter_r0;
wire [15:0]filter_r1;
wire [15:0]filter_r2;
wire [15:0]filter_r3;
wire [15:0]filter_r4;
reg  [4:0]cnt_mem_w;
wire [4:0]cnt_mem_w_wire;

wire [31:0]out_fm_0;
wire [31:0]out_fm_1;
wire [31:0]out_fm_2;
wire [31:0]out_fm_3;
wire [31:0]out_fm_4;
reg  [4:0]cnt_mem_o;
wire [4:0]cnt_mem_o_wire;

wire [2:0]pop_out;
reg  [4:0]cnt_global;
wire [4:0]cnt_global_wire;
wire [4:0]row_flag;
wire row_fini;
wire [15:0]input_fm_temp;
wire Mem_in_EN_wire;
reg Mem_in_EN;

assign cnt_mem_w_wire = cnt_mem_w;
assign cnt_mem_in_wire = cnt_mem_in;
assign cnt_mem_o_wire = cnt_mem_o;
assign cnt_global_wire = cnt_global;
assign row_fini = (cnt_global == (row_flag + 2) ? 1 : 0);
assign row_flag = (cnt_global == 1'b1 ? input_fm[15:8] : row_flag) ;
assign input_fm = (cnt_global == (row_flag + 2) ? 0 : input_fm_temp);
assign Mem_in_EN_wire = Mem_in_EN ;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        cnt_global <= 0;      
    end
    else if (cnt_global == 0) begin
        cnt_global <= cnt_global + 1'b1;
    end
    else if (cnt_global != 0 )begin
        if (cnt_global == row_flag + 2'd2) begin
            cnt_global <= 5'b1;
        end
        else cnt_global <= cnt_global +1'b1;
    end
end

 PE #(
        .row_length   (row_length ),
        .filter_size  (filter_size)
        // .filename     (filename)   
    )
       PE1(
        .in(input_fm[7:0]),

        .weight_0(filter_r0[7:0]), 
        .weight_1(filter_r1[7:0]),
        .weight_2(filter_r2[7:0]),
        .weight_3(filter_r3[7:0]),
        .weight_4(filter_r4[7:0]),

        .index_in(input_fm[15:8]),

        .index_w_0(filter_r0[15:8]), 
        .index_w_1(filter_r1[15:8]), 
        .index_w_2(filter_r2[15:8]), 
        .index_w_3(filter_r3[15:8]), 
        .index_w_4(filter_r4[15:8]), 

        .out_temp_0(out_fm_0[23:0]), 
        .out_temp_1(out_fm_1[23:0]), 
        .out_temp_2(out_fm_2[23:0]), 
        .out_temp_3(out_fm_3[23:0]), 
        .out_temp_4(out_fm_4[23:0]),

        .index_o_0(out_fm_0[31:24]), 
        .index_o_1(out_fm_1[31:24]), 
        .index_o_2(out_fm_2[31:24]), 
        .index_o_3(out_fm_3[31:24]), 
        .index_o_4(out_fm_4[31:24]),

        .clk(clk),
        .rst(rst),
        .pop_index(pop_out),
        .cnt(cnt_global_wire)
        );

always @(posedge clk or posedge rst)begin 
    if (rst)begin
        cnt_mem_in  <= 0;
    end
    else if(cnt_global == row_flag)begin
        cnt_mem_in <= cnt_mem_in;
    end
    else begin
        cnt_mem_in <= cnt_mem_in +1'b1;
    end
end

always @(negedge clk or posedge rst) begin
    if (rst) begin        
        Mem_in_EN <= 1'b1;      
    end
    else if(cnt_global == row_flag + 1'b1) begin
        Mem_in_EN <= 0;
    end
    else begin
        Mem_in_EN <= 1'b1;
    end
end


Mem_PE #(
        .WORD_WIDTH  (WORD_WIDTH_IN),
        .ADDR_WIDTH  (ADDR_WIDTH_IN),
        .RAM_DEPTH   (RAM_DEPTH_IN),
        .FILENAME    (FILENAME_IN) 
    )
        Mem_PE_in(
        // .data_in(in_data), 
        .data_out(input_fm_temp), 
        .addr(cnt_mem_in_wire), 
        .clk(clk), 
        .rst(rst),
        .Mem_EN(Mem_in_EN_wire)
        );

always @(posedge clk or posedge rst)begin 
    if (rst)begin
        cnt_mem_w  <= 0;
    end
    else begin
        if (cnt_global == 0)begin
            cnt_mem_w <= 0;
        end
        else begin
            cnt_mem_w <= cnt_mem_w ;
        end
    end
end


Mem_5_out #(
        .WORD_WIDTH  (WORD_WIDTH_W),
        .ADDR_WIDTH  (ADDR_WIDTH_W),
        .RAM_DEPTH   (RAM_DEPTH_W),
        .FILENAME    (FILENAME_W)   
    )
        Mem_PE_w(
        // .data_in(in_data), 
        // .data_out(data_out_tb), 
        .data_out_0(filter_r0),
        .data_out_1(filter_r1),
        .data_out_2(filter_r2),
        .data_out_3(filter_r3),
        .data_out_4(filter_r4),
        .addr(cnt_mem_w_wire), 
        .clk(clk), 
        .rst(rst)
        );


always @(posedge clk or posedge rst)begin 
    if (rst)begin
        cnt_mem_o  <= 0;
    end
    else begin
        if (cnt_global <= 2'd2)begin
            cnt_mem_o <= cnt_mem_o;
        end
        else if (cnt_global == row_flag + 2)begin
            cnt_mem_o <= cnt_mem_o + filter_size;
        end
        else begin
            cnt_mem_o <= cnt_mem_o + pop_out ;
        end
    end
end


Mem_5_in #(
        .WORD_WIDTH  (WORD_WIDTH_O),
        .ADDR_WIDTH  (ADDR_WIDTH_O),
        .RAM_DEPTH   (RAM_DEPTH_O),
        .FILENAME    (FILENAME_O) 
    )
        Mem_PE_o(
        .data_in_0(out_fm_0), 
        .data_in_1(out_fm_1),
        .data_in_2(out_fm_2),
        .data_in_3(out_fm_3),
        .data_in_4(out_fm_4),
        .pop_num(pop_out),
        // .data_out(data_out_tb), 
        .addr(cnt_mem_o_wire), 
        .clk(clk), 
        .rst(rst),
        .row_fini(row_fini)
        );

endmodule

