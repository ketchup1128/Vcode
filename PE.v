module PE(
    in, index_in, cnt,
    weight_0,   weight_1,   weight_2,   weight_3,   weight_4,
    index_w_0,  index_w_1,  index_w_2,  index_w_3,  index_w_4,
    out_temp_0, out_temp_1, out_temp_2, out_temp_3, out_temp_4,
    index_o_0,  index_o_1,  index_o_2,  index_o_3,  index_o_4,
    pop_index,
    clk, rst
    );

parameter   row_length  = 28;
parameter   filter_size = 5;

input [7:0]in;
input [7:0]index_in;

input [7:0]weight_0;
input [7:0]weight_1;
input [7:0]weight_2;
input [7:0]weight_3;
input [7:0]weight_4;

input [7:0]index_w_0;
input [7:0]index_w_1;
input [7:0]index_w_2;
input [7:0]index_w_3;
input [7:0]index_w_4;

output [31:0]out_temp_0;
output [31:0]out_temp_1;
output [31:0]out_temp_2;
output [31:0]out_temp_3;
output [31:0]out_temp_4;

output [7:0]index_o_0;
output [7:0]index_o_1;
output [7:0]index_o_2;
output [7:0]index_o_3;
output [7:0]index_o_4;

output [2:0] pop_index;

input clk, rst;
input [4:0] cnt;

wire [15:0]out_0;
wire [15:0]out_1;
wire [15:0]out_2;
wire [15:0]out_3;
wire [15:0]out_4;

reg [31:0]out_temp_0;
reg [31:0]out_temp_1;
reg [31:0]out_temp_2;
reg [31:0]out_temp_3;
reg [31:0]out_temp_4;

wire [7:0]index_o_0;
wire [7:0]index_o_1;
wire [7:0]index_o_2;
wire [7:0]index_o_3;
wire [7:0]index_o_4; 

wire [2:0] pop_index;

wire [7:0]in_reg;
wire [7:0]index_in_reg;

wire [7:0]weight_0_reg;
wire [7:0]weight_1_reg;
wire [7:0]weight_2_reg;
wire [7:0]weight_3_reg;
wire [7:0]weight_4_reg;

wire [7:0]index_w_0_reg;
wire [7:0]index_w_1_reg;
wire [7:0]index_w_2_reg;
wire [7:0]index_w_3_reg;
wire [7:0]index_w_4_reg;

assign  in_reg = (rst == 1 ? 0 : (cnt >= 2'd2 ? in : in_reg))  ;
assign  index_in_reg = (rst ==1 ? 0 : (cnt >= 2'd2 ? index_in  : index_in_reg ));  
assign  weight_0_reg = (rst ==1 ? 0 : (cnt >= 2'd2 ? weight_0  : weight_0_reg ));  
assign  weight_1_reg = (rst ==1 ? 0 : (cnt >= 2'd2 ? weight_1  : weight_1_reg ));  
assign  weight_2_reg = (rst ==1 ? 0 : (cnt >= 2'd2 ? weight_2  : weight_2_reg ));  
assign  weight_3_reg = (rst ==1 ? 0 : (cnt >= 2'd2 ? weight_3  : weight_3_reg ));  
assign  weight_4_reg = (rst ==1 ? 0 : (cnt >= 2'd2 ? weight_4  : weight_4_reg ));  
assign  index_w_0_reg= (rst ==1 ? 0 : (cnt >= 2'd2 ? index_w_0 : index_w_0_reg));  
assign  index_w_1_reg= (rst ==1 ? 0 : (cnt >= 2'd2 ? index_w_1 : index_w_1_reg));  
assign  index_w_2_reg= (rst ==1 ? 0 : (cnt >= 2'd2 ? index_w_2 : index_w_2_reg));  
assign  index_w_3_reg= (rst ==1 ? 0 : (cnt >= 2'd2 ? index_w_3 : index_w_3_reg));  
assign  index_w_4_reg= (rst ==1 ? 0 : (cnt >= 2'd2 ? index_w_4 : index_w_4_reg));  

mac #(
    .row_length (row_length),
    .filter_size(filter_size)
    ) mac0 (

        .in(in_reg),
        .weight(weight_0_reg),
        .index_in(index_in_reg),
        .index_w(index_w_0_reg),
        .out(out_0),
        .index_o(index_o_0),
        .clk(clk),
        .rst(rst)

    );

mac #(
    .row_length (row_length),
    .filter_size(filter_size)
    ) mac1 (

        .in(in_reg),
        .weight(weight_1_reg),
        .index_in(index_in_reg),
        .index_w(index_w_1_reg),
        .out(out_1),
        .index_o(index_o_1),
        .clk(clk),
        .rst(rst)

    );

mac #(
    .row_length (row_length),
    .filter_size(filter_size)
    ) mac2 (

        .in(in_reg),
        .weight(weight_2_reg),
        .index_in(index_in_reg),
        .index_w(index_w_2_reg),
        .out(out_2),
        .index_o(index_o_2),
        .clk(clk),
        .rst(rst)

    );

mac #(
    .row_length (row_length),
    .filter_size(filter_size)
    ) mac3 (

        .in(in_reg),
        .weight(weight_3_reg),
        .index_in(index_in_reg),
        .index_w(index_w_3_reg),
        .out(out_3),
        .index_o(index_o_3),
        .clk(clk),
        .rst(rst)

    );

mac #(
    .row_length (row_length),
    .filter_size(filter_size)
    ) mac4 (

        .in(in_reg),
        .weight(weight_4_reg),
        .index_in(index_in_reg),
        .index_w(index_w_4_reg),
        .out(out_4),
        .index_o(index_o_4),
        .clk(clk),
        .rst(rst)

    );



assign pop_index = index_o_0 == 0 ? 0 : index_in_reg - index_o_0;

always @(posedge clk or posedge rst) begin 
    if (rst) begin
        out_temp_0 <= 32'b0;
        out_temp_1 <= 32'b0;
        out_temp_2 <= 32'b0;
        out_temp_3 <= 32'b0;
        out_temp_4 <= 32'b0;
    end
    else if (cnt == 1'b1)begin
        out_temp_0 <= 32'b0;
        out_temp_1 <= 32'b0;
        out_temp_2 <= 32'b0;
        out_temp_3 <= 32'b0;
        out_temp_4 <= 32'b0;
        end 
    else begin 
        case (index_in_reg - index_o_0)
        7'd1:begin
            out_temp_4 <= out_4 + out_temp_3;
            out_temp_3 <= out_3 + out_temp_2;
            out_temp_2 <= out_2 + out_temp_1;
            out_temp_1 <= out_1 + out_temp_0;
            out_temp_0 <= out_0;
        end
        7'd2:begin
            out_temp_4 <= out_4 + out_temp_2;
            out_temp_3 <= out_3 + out_temp_1;
            out_temp_2 <= out_2 + out_temp_0;
            out_temp_1 <= out_1;
            out_temp_0 <= out_0;
        end
        7'd3:begin
            out_temp_4 <= out_4 + out_temp_1;
            out_temp_3 <= out_3 + out_temp_0;
            out_temp_2 <= out_2; 
            out_temp_1 <= out_1;
            out_temp_0 <= out_0;
        end
        7'd4:begin
            out_temp_4 <= out_4 + out_temp_0;
            out_temp_3 <= out_3;
            out_temp_2 <= out_2; 
            out_temp_1 <= out_1;
            out_temp_0 <= out_0;
        end
        default:begin
            out_temp_0 <= out_temp_0;
            out_temp_1 <= out_temp_1;
            out_temp_2 <= out_temp_2;
            out_temp_3 <= out_temp_3;
            out_temp_4 <= out_temp_4;
        end
        endcase
    end
end

endmodule


