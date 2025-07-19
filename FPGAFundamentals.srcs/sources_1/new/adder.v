`timescale 1ns / 1ps

module adder(
    input wire A, B, C_in,
    output wire S, C_out
    );
    
    assign S = A ^ B ^ C_in;
    assign  C_out = A & B | A & C_in | B & C_in;
endmodule
