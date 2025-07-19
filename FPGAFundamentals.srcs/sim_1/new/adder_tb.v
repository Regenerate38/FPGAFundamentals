`timescale 1ns / 1ps

module adder_tb;

    reg [3:0]A;
    reg [3:0]B;
    reg C_in;
    wire [3:0]S;
    wire C_out;
    
    adder_4b uut (
        .A(A), .B(B) ,.C_in(C_in), .S (S), .C_out(C_out)
    );
    
 initial begin
    A = 4'b0000; B = 4'b0000; C_in = 0; 
    // Sum = 0000, Carry_out = 0
    #20; A = 4'b0000; B = 4'b0001; C_in = 0; 
    // Sum = 0001, Carry_out = 0
    #20; A = 4'b0010; B = 4'b0011; C_in = 0; 
    // Sum = 0101, Carry_out = 0
    #20; A = 4'b0101; B = 4'b0110; C_in = 1; 
    // Sum = 1100, Carry_out = 0
    #20; A = 4'b1111; B = 4'b0001; C_in = 0; 
    // Sum = 0000, Carry_out = 1
    #20; A = 4'b1010; B = 4'b0101; C_in = 1; 
    // Sum = 0000, Carry_out = 1
    #20; A = 4'b1111; B = 4'b1111; C_in = 1; 
    // Sum = 1111, Carry_out = 1
    #20;
    $finish;
    end
endmodule
