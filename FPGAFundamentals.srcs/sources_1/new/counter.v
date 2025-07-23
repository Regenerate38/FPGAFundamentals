`timescale 1ns / 1ps

module bin_counter(
        input wire CLK, 
        input wire RST,
        output wire [3:0] OUT
    );
    wire Q0, Q1, Q2, Q3;
    wire Q0_bar, Q1_bar, Q2_bar;
    assign OUT = {Q3, Q2, Q1, Q0};
    t_flipflop t0(.T(1'b1), .CLK(CLK), .RST(RST), .Q(Q0), .Q_bar(Q0_bar));
    t_flipflop t1(.T(1'b1), .CLK(Q0_bar), .RST(RST), .Q(Q1), .Q_bar(Q1_bar));
    t_flipflop t2(.T(1'b1), .CLK(Q1_bar), .RST(RST), .Q(Q2), .Q_bar(Q2_bar));
    t_flipflop t3(.T(1'b1), .CLK(Q2_bar), .RST(RST), .Q(Q3), .Q_bar());
    
endmodule


module bin_down_counter(
        input wire CLK, 
        input wire RST,
        output wire [3:0] OUT
    );
    wire Q0, Q1, Q2, Q3;
    wire Q0_bar, Q1_bar, Q2_bar, JK2_IN, JK3_IN;    
    assign OUT = {Q3, Q2, Q1, Q0};
    assign JK2_IN = (Q0_bar & Q1_bar);
    assign JK3_IN = (JK2_IN & Q2_bar);
    jk_flipflop jk0(.J(1'b1), .K(1'b1), .CLK(CLK), .RST(RST), .Q(Q0), .Q_bar(Q0_bar));
    jk_flipflop jk1(.J(Q0_bar), .K(Q0_bar), .CLK(CLK), .RST(RST), .Q(Q1), .Q_bar(Q1_bar));
    jk_flipflop jk2(.J(JK2_IN), .K(JK2_IN), .CLK(CLK), .RST(RST), .Q(Q2), .Q_bar(Q2_bar));
    jk_flipflop jk3(.J(JK3_IN), .K(JK3_IN), .CLK(CLK), .RST(RST), .Q(Q3), .Q_bar());
    
endmodule