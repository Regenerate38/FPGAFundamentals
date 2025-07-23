`timescale 1ns / 1ps

module clock_divider_tb;
    reg CLK;
    reg RST;
    wire Q;
    
    clock_divider uut (
        .CLK(CLK), .RST(RST), .Q(Q)
    );
    initial CLK = 1;
    always #10 CLK = ~CLK;
    initial begin;
        RST = 1;
        @(posedge CLK);
        RST = 0;
        @(posedge CLK);
        #100;
        $finish;
    end
endmodule
