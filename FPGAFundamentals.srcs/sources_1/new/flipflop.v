`timescale 1ns / 1ps
// Using Structural Modelling
// and(), or(), not(), nand(), nor(), xor(), xnor(), wire
// and(Output, Input1, Input2)

module sr_flipflop(
    output wire Q,
    output wire Q_bar,
    input wire S,
    input wire R, 
    input wire CLK
    );
    wire S_CLK, R_CLK;
    
    nand(S_CLK, S, CLK);
    nand(R_CLK, R, CLK);    
    nand (Q, S_CLK, Q_bar);
    nand(Q_bar, R_CLK, Q);
    
endmodule


module d_flipflop(
    output wire Q,
    output wire Q_bar,
    input wire D,
    input wire CLK
    );
    wire S = D;
    wire R = ~D;
    sr_flipflop d (
    .S(S), .R(R), .CLK(CLK), .Q(Q), .Q_bar(Q_bar)
    );
    
endmodule