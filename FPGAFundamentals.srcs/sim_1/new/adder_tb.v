`timescale 1ns / 1ps

module adder_tb;

    reg A, B, C_in;
    wire S, C_out;
    
    adder uut (
        .A(A), .B(B) ,.C_in(C_in), .S (S), .C_out(C_out)
    );
    
    initial begin
      A = 0; B = 0; C_in = 0;
        #20; A = 0; B = 0; C_in = 1;
        #20; A = 0; B = 1; C_in = 0;
        #20; A = 0; B = 1; C_in = 1;
        #20; A = 1; B = 0; C_in = 0;
        #20; A = 1; B = 0; C_in = 1;
        #20; A = 1; B = 1; C_in = 0;
        #20; A = 1; B = 1; C_in = 1;
        #20;
        $finish;
    end
    
endmodule
