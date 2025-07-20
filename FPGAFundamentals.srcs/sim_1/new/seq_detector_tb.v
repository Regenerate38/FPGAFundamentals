`timescale 1ns / 1ps

module seq_detector_tb;
    reg x;
    reg clk;
    reg rst;
    wire z;
    
    
    seq_detector uut (
    .x(x), .clk(clk), .rst(rst), .z(z));
    
    initial clk = 1;
    always #5 clk = ~clk;
    
    
    
    
    initial begin
        rst = 1;
        #10;
        rst = 0;
        
        @(posedge clk);
        
        x = 0;
        @(posedge clk);
        x = 1;
        @(posedge clk);
        x = 0;
        @(posedge clk);
        x = 1;
        @(posedge clk);
        $finish;
    end
    
endmodule
