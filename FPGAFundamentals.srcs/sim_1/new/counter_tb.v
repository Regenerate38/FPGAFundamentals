`timescale 1ns / 1ps

module counter_tb;
    reg CLK;
    wire Q0, Q1, Q2, Q3;
    
    bin_counter uut (
        .CLK(CLK), .Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3)
        );
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  
    end
    
    initial begin
        #200;
        $finish;
    end
    
endmodule
