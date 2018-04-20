module mac(in, index_in, weight, index_w, out, index_o, clk, rst);
parameter   row_length = 28;
parameter   filter_size = 5;
input       [7:0]in;
input       [7:0]weight;
input       [7:0]index_in;
input       [7:0]index_w;
input       clk, rst;

output      [15:0]out;
output      [7:0]index_o;

reg         [15:0]out;
reg         [7:0]index_o;
    

always @(*) begin
    if (rst) begin
        out = 16'b0;
        index_o = 8'b0;
    end
    else begin
        if ((index_in >= index_w) && (index_in - index_w) <= row_length - filter_size)
            out = in*weight;
        else  
            out = 16'b0; 
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        index_o <= 8'b0;     
    end
    else begin
        index_o = index_in - index_w;
    end
end

endmodule



