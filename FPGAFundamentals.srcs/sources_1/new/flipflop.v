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


module jk_flipflop(
    input wire J,
    input wire K, 
    input wire CLK,
    input wire RST,
    output reg Q, 
    output wire Q_bar
);
// Structural Implementation
//wire S_bar, R_bar;
//assign S_bar = ~(J & Q_bar & CLK);
//assign R_bar = ~(K & Q & CLK);

//sr_flipflop jk (
//    .S(S_bar), .R(R_bar), .CLK(CLK), .Q(Q), .Q_bar(Q_bar)
//);

// Behavioral Implementation:
assign Q_bar = ~Q;

    always @(posedge CLK or posedge RST) begin
        if (RST)
            Q <= 0;
        else begin
            case ({J,K})
                2'b00: Q <= Q;
                2'b01: Q<=0;
                2'b10: Q<=1;
                2'b11: Q<= ~Q;
            endcase
        end
    end
endmodule


module t_flipflop(
    input wire T,
    input wire CLK,
    input wire RST,
    output wire Q,
    output wire Q_bar
);
jk_flipflop T_FF (
    .J(T), .K(T), .RST(RST), .CLK(CLK) ,.Q(Q), .Q_bar(Q_bar)
);
endmodule