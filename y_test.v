module test_y();
reg clk_i, rst_i, start_i;
reg [7:0] a_bi, b_bi;
wire busy_o;
wire [15:0] res;

y_function func(clk_i, rst_i, a_bi, b_bi, start_i, busy_o, res);

initial begin
    clk_i = 1; 
    start_i = 1; 
    rst_i = 1;
    #5
    rst_i = 0;
    a_bi = 8'h3;
    b_bi = 8'd121;
    #120
    if (!busy_o && res != 0) begin
        a_bi = 8'd4;
        b_bi = 8'd49; 
    end
    
     
end

always #5 clk_i = ~clk_i;
    
endmodule
