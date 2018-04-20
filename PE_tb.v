`timescale 1ns/100ps
module PE_tb;

reg [7:0]in_tb;
// reg [7:0]in_1_tb;
// reg [7:0]in_2_tb;
// reg [7:0]in_3_tb;
// reg [7:0]in_4_tb;

reg [7:0]weight_0_tb;
reg [7:0]weight_1_tb;
reg [7:0]weight_2_tb;
reg [7:0]weight_3_tb;
reg [7:0]weight_4_tb;

reg [7:0]index_in_tb;
// reg [7:0]index_in_1_tb;
// reg [7:0]index_in_2_tb;
// reg [7:0]index_in_3_tb;
// reg [7:0]index_in_4_tb;

reg [7:0]index_w_0_tb;
reg [7:0]index_w_1_tb;
reg [7:0]index_w_2_tb;
reg [7:0]index_w_3_tb;
reg [7:0]index_w_4_tb;

reg clk_tb,rst_tb;

// wire [15:0]out_0_tb;
// wire [15:0]out_1_tb;
// wire [15:0]out_2_tb;
// wire [15:0]out_3_tb;
// wire [15:0]out_4_tb;

wire [31:0]out_temp_0_tb;
wire [31:0]out_temp_1_tb;
wire [31:0]out_temp_2_tb;
wire [31:0]out_temp_3_tb;
wire [31:0]out_temp_4_tb;

wire [7:0]index_o_0_tb;
wire [7:0]index_o_1_tb;
wire [7:0]index_o_2_tb;
wire [7:0]index_o_3_tb;
wire [7:0]index_o_4_tb;

wire [2:0]pop_index_tb;

// wire [31:0]test_tb;

PE AAA(
    .in(in_tb),
    // .in_0(in_0_tb), .in_1(in_1_tb), .in_2(in_2_tb), .in_3(in_3_tb), .in_4(in_4_tb),
    .weight_0(weight_0_tb), .weight_1(weight_1_tb),.weight_2(weight_2_tb),.weight_3(weight_3_tb),.weight_4(weight_4_tb),
    .index_in(index_in_tb),
    // .index_in_0(index_in_0_tb), .index_in_1(index_in_1_tb), .index_in_2(index_in_2_tb), .index_in_3(index_in_3_tb), .index_in_4(index_in_4_tb),
    .index_w_0(index_w_0_tb), .index_w_1(index_w_1_tb), .index_w_2(index_w_2_tb), .index_w_3(index_w_3_tb), .index_w_4(index_w_4_tb),  
    // .out_0(out_0_tb), .out_1(out_1_tb), .out_2(out_2_tb), .out_3(out_3_tb), .out_4(out_4_tb),
    .out_temp_0(out_temp_0_tb), .out_temp_1(out_temp_1_tb), .out_temp_2(out_temp_2_tb), .out_temp_3(out_temp_3_tb), .out_temp_4(out_temp_4_tb),
    .index_o_0(index_o_0_tb), .index_o_1(index_o_1_tb), .index_o_2(index_o_2_tb), .index_o_3(index_o_3_tb), .index_o_4(index_o_4_tb),
    .clk(clk_tb),
    .rst(rst_tb),
    .pop_index(pop_index_tb)
    // .test(test_tb)
    );

always begin
    #20
    clk_tb = ~clk_tb;
end

initial begin 
    rst_tb         = 1'b0;
    clk_tb         = 1'b0;

    weight_0_tb    = 8'd5;
    weight_1_tb    = 8'd4;
    weight_2_tb    = 8'd3;
    weight_3_tb    = 8'd2;
    weight_4_tb    = 8'd1;

    index_w_0_tb   = 8'd0;
    index_w_1_tb   = 8'd1;
    index_w_2_tb   = 8'd2;
    index_w_3_tb   = 8'd3;
    index_w_4_tb   = 8'd4; 

    #5 rst_tb     = 1'b1;
    #10 rst_tb     = 1'b0;

    #5;
    in_tb = 8'd25;
    index_in_tb = 8'd3;

    #40;

    in_tb = 8'd5;
    index_in_tb = 8'd5;

    #40;

    in_tb = 8'd4;
    index_in_tb = 8'd7;   

    #100;

    $finish;
    
    end
    
endmodule