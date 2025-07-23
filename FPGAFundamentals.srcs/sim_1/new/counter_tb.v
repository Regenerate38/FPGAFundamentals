`timescale 1ns / 1ps

module counter_tb;
    reg CLK, RST;
    wire [3:0] OUT;
    
    bin_down_counter uut (
        .CLK(CLK), .RST(RST), .OUT(OUT)
        );
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  
    end
    
    initial begin
        RST = 1;
        @(posedge CLK);
        RST = 0;
        @(posedge CLK);
        #200;
        $finish;
    end
    
endmodule
