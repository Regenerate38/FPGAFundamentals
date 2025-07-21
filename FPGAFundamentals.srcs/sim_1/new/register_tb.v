`timescale 1ns / 1ps

module register_tb;
    reg Din;
    reg CLK;
    wire Out;
    wire Q3;
    wire Q2;
    wire Q1;
    reg D2;
    reg D1;
    reg D0;
    
//    siso_register uut (
//        .Din(Din), .CLK(CLK), .Out(Out)
//    );

//    sipo_register uut (
//        .Din(Din), .CLK(CLK), .Out(Out), .Q3(Q3), .Q2(Q2), .Q1(Q1)
//    );

    pipo_register uut (
        .D3(Din), .D2(D2), .D1(D1), .D0(D0), .CLK(CLK), .Q3(Q3), .Q2(Q2), .Q1(Q1), .Out(Out)
    );
    initial CLK = 0;
    always #5 CLK=~ CLK;
    initial begin
     @(posedge CLK);
     Din = 1;
     D2 = 0;
     D1 = 1;
     D0 = 1;
     @(posedge CLK);
     $finish;
    end
endmodule
