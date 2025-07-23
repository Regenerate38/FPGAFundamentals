`timescale 1ns / 1ps

module clock_divider(
    input CLK,
    input RST,
    output Q
);
    wire internal;
    d_flipflop d1(
        .CLK(CLK), .RST(RST), .Q(Q), .D(internal), .Q_bar(internal)
    );
    
endmodule
