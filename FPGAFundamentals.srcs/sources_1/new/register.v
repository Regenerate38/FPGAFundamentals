`timescale 1ns / 1ps

module siso_register(
    input wire CLK,
    input wire Din,
    output wire Out
    );
    wire Q3, Q2, Q1;
    
    d_flipflop FF3 (
      .D(Din), .CLK(CLK), .Q(Q3)
    );

    d_flipflop FF2 (
      .D(Q3), .CLK(CLK), .Q(Q2)
    );
    
    d_flipflop FF1 (
      .D(Q2), .CLK(CLK), .Q(Q1)
    );
    
    d_flipflop FF0 (
      .D(Q1), .CLK(CLK), .Q(Out)
    );
endmodule
