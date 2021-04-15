`timescale 1ns / 1ps

module root_tb();
    reg clk;
    reg rst;
    reg [7:0] x;
    reg start;
    wire [1:0] root_busy;
    wire [3:0] result;
    
    root root1 (
        .clk_i(clk),
        .rst_i(rst),
        .start_i(start),
        .x_bi(x),
        .busy_o(root_busy),
        .y_bo(result)
    );
    
    initial begin
        clk=1; rst=1;
        #1
        clk=0; rst=0;
        #1
        x=8'd255; clk=1; start=1;
        #1 clk=0; #1 clk=1; start=0;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
    end
endmodule