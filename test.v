module test;
reg [15:0] mem [0:3];

integer i;

initial 
begin
    $readmemb("men.dat", mem);
    for (i = 0; i < 3; i = i + 1)
        $dispaly("Memory [%d] = %b ", i, mem[i]);
end
endmodule


