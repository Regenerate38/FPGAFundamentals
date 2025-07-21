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


module sipo_register(
    input wire CLK,
    input wire Din,
    output wire Out,
    output wire Q3,
    output wire Q2,
    output wire Q1

    );
    
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

module pipo_register(
    input wire CLK,
    input wire D3,
    input wire D2,
    input wire D1,
    input wire D0,
    output wire Out,
    output wire Q3,
    output wire Q2,
    output wire Q1

    );
    
    d_flipflop FF3 (
      .D(D3), .CLK(CLK), .Q(Q3)
    );

    d_flipflop FF2 (
      .D(D2), .CLK(CLK), .Q(Q2)
    );
    
    d_flipflop FF1 (
      .D(D1), .CLK(CLK), .Q(Q1)
    );
    
    d_flipflop FF0 (
      .D(D0), .CLK(CLK), .Q(Out)
    );
endmodule


