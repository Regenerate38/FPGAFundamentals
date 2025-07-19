`timescale 1ns / 1ps

module flipflop_tb;
    reg D;
    
    reg CLK;
    initial CLK = 0;
    always #5 CLK = ~CLK;
    
    wire Q, Q_bar;
//    sr_flipflop uut (
//        .S(S), .R(R), .CLK(CLK), .Q(Q), .Q_bar(Q_bar)
//    );
 
     d_flipflop uut (
        .D(D), .CLK(CLK), .Q(Q), .Q_bar(Q_bar)
    );
    
//    task din_sr(input s_in, input r_in);
//        begin
//          @(negedge CLK);
//          S = s_in;
//          R = r_in;
//        end
//    endtask
    
      task din_d(input d_in);
        begin
          @(negedge CLK);
          D = d_in;
        end
    endtask
    
    initial begin
    D = 0;
    din_d(0);
    din_d(1);
    din_d(0);
    din_d(1);
    #20;
    $finish;
    end
    
endmodule
