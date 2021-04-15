module test();

reg clk_i, rst_i, start_i;
reg [7:0] a_bi, b_bi;
wire busy_o;
wire [15:0] y_bo;

multer multer_0(clk_i, rst_i, a_bi, b_bi, start_i, busy_o, y_bo);

initial begin
    clk_i = 1; 
    start_i = 1; 
    rst_i = 1;
    #5
    rst_i = 0;
    a_bi = 8'b111;
    b_bi = 8'b10;   
end

always #5 clk_i = ~clk_i;

endmodule