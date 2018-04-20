`timescale 1ns/100ps
module top_PE_tb;
reg clk_tb;
reg rst_tb;
wire [2:0]pop_out_tb;

top_PE aaa(
    .clk(clk_tb),
    .rst(rst_tb),
    .pop_out(pop_out_tb)
    );

always begin
    #20
    clk_tb = ~clk_tb;
end

initial begin 
    rst_tb         = 1'b0;
    clk_tb         = 1'b0;
    #10 rst_tb     = 1'b1;
    #10 rst_tb     = 1'b0;

    #750;
    $finish;
end

endmodule

