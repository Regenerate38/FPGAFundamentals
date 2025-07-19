`timescale 1ns / 1ps

module adder(
    input wire A, B, C_in,
    output wire S, C_out
    );
    
    assign S = A ^ B ^ C_in;
    assign  C_out = A & B | A & C_in | B & C_in;
endmodule


module adder_4b(
    input wire [3:0]A,
    input wire [3:0]B,
    input wire  C_in,
    output wire [3:0]S,
    input wire C_out
    );
    
    wire [2:0] C_temp;
   
    adder adder0 (
    .A(A[0]), .B(B[0]) ,.C_in(C_in), .S (S[0]), .C_out(C_temp[0])
    );
    
    adder adder1 (
    .A(A[1]), .B(B[1]) ,.C_in(C_temp[0]), .S (S[1]), .C_out(C_temp[1])
    );
    
    adder adder2 (
    .A(A[2]), .B(B[2]) ,.C_in(C_temp[1]), .S (S[2]), .C_out(C_temp[2])
    );
    
    adder adder3 (
    .A(A[3]), .B(B[3]) ,.C_in(C_temp[2]), .S (S[3]), .C_out(C_out)
    );
    
endmodule