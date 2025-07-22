`timescale 1ns / 1ps

module bin_counter(
        input wire CLK, 
        output wire Q0, 
        output wire Q1,
        output wire Q2, 
        output wire Q3
    );
    wire Q0_bar, Q1_bar, Q2_bar;
    t_flipflop t0(.T(1'b1), .CLK(CLK), .RST(1'b0), .Q(Q0), .Q_bar(Q0_bar));
    t_flipflop t1(.T(1'b1), .CLK(Q0_bar), .RST(1'b0), .Q(Q1), .Q_bar(Q1_bar));
    t_flipflop t2(.T(1'b1), .CLK(Q1_bar), .RST(1'b0), .Q(Q2), .Q_bar(Q2_bar));
    t_flipflop t3(.T(1'b1), .CLK(Q2_bar), .RST(1'b0), .Q(Q3), .Q_bar());
    
endmodule
