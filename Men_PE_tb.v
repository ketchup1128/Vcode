`timescale 1ns/100ps
module Men_PE_tb;

parameter wordsize = 16;
parameter memsize  = 3;

reg [wordsize - 1 : 0]data_in_tb;
reg [memsize  - 1 : 0]addr_tb;
reg clk_tb;
reg rst_tb;

wire [wordsize -1 : 0]data_out_tb;

Mem_PE aaa(
    .data_in(data_in_tb), 
    .data_out(data_out_tb), 
    .addr(addr_tb), 
    .clk(clk_tb), 
    .rst(rst_tb)
    );

always begin
    #20;
    clk_tb = ~clk_tb;
end

initial begin
    rst_tb         = 1'b0;
    clk_tb         = 1'b0;
    #17 rst_tb     = 1'b1;
    #10 rst_tb     = 1'b0;
    #25;
    addr_tb = 3'b001;
    #100;

    $finish;
end

endmodule


