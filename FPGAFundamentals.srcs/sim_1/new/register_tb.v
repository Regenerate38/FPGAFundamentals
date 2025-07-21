`timescale 1ns / 1ps

module register_tb;
    reg Din;
    reg CLK;
    wire Out;
    
    siso_register uut (
        .Din(Din), .CLK(CLK), .Out(Out)
    );
    initial CLK = 0;
    always #5 CLK=~ CLK;
    initial begin
     @(posedge CLK);
     Din = 1;
     @(posedge CLK);
     Din = 0;
     @(posedge CLK);
     Din = 1;
     @(posedge CLK);
     Din = 1;
     @(posedge CLK);
     Din = 0;
     @(posedge CLK);
     Din = 0;
     @(posedge CLK);
     Din = 0;
     @(posedge CLK);
     Din = 0;
     @(posedge CLK);
          @(posedge CLK);
     $finish;
    end
endmodule
