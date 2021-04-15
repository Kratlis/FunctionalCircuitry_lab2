`timescale 1ns / 1ps


module y_function(
    input clk_i,
    input rst_i,
    
    input [7:0] a_bi,
    input [7:0] b_bi,
    input start_i,
    
    output busy_o,
    output reg [15:0] res 
    );
    
    localparam IDLE = 1'b0;
    localparam WORK = 1'b1;
    
    reg [7:0] a;
    reg [7:0] b;
    
    reg [23:0] part_result;
    
    reg state;
    reg start_mult;
    reg start_root;
    
    wire [15:0] mult_result;
    wire [3:0] root_result;
    wire [1:0] mult_busy;
    wire [1:0] root_busy;
    wire done;
    
    multer mult0(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .a_bi(a),
        .b_bi(a),
        .start_i(start_mult),
        .busy_o(mult_busy),
        .y_bo(mult_result)
    );
    root root0 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .start_i(start_root),
        .x_bi(b),
        .busy_o(root_busy),
        .y_bo(root_result)
    );
    
    assign busy_o = state;
    assign done = root_busy == 0 && mult_busy == 0 && 
    (root_result != 0 && b!=0 || root_result == 0 && b==0 ) && 
    (mult_result != 0 && a!= 0 || mult_result == 0 && a== 0);
    
    always @(posedge clk_i) begin
        if(rst_i) begin
            state <= IDLE;
            res <= 0;
        end else begin
            case(state)
                IDLE:
                    if(start_i) begin
                        part_result <= 0;
                        a <= a_bi;
                        b <= b_bi;
                        state <= WORK;
                        start_mult <= 1;
                        start_root <= 1;
                    end
                WORK:
                    begin
                        if(done) begin
                            state <= IDLE;
                            res <= mult_result + root_result;
                        end 
                    end      
            endcase
        end
    end
    
    always @(root_busy) begin
        if(root_busy == 1) start_root <= 0;
    end
    
    always @(mult_busy) begin
        if(mult_busy == 1) start_mult <= 0;
    end
    
    
endmodule
