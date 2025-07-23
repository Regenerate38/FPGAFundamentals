`timescale 1ns / 1ps

module flipflop_tb;
    reg T;
    reg CLK;
    reg RST;
    initial CLK = 0;
    always #5 CLK = ~CLK;
    
    wire Q, Q_bar;
//    sr_flipflop uut (
//        .S(S), .R(R), .CLK(CLK), .Q(Q), .Q_bar(Q_bar)
//    );
 
//     d_flipflop uut (
//        .D(D), .CLK(CLK), .Q(Q), .Q_bar(Q_bar)
//    );
    
//       jk_flipflop uut (
//        .J(J), .K(K), .CLK(CLK), .Q(Q), .Q_bar(Q_bar)
//       );
    
     t_flipflop uut (
        .T(T), .CLK(CLK),.RST(RST), .Q(Q), .Q_bar(Q_bar)
    );
    
//    task din_sr(input s_in, input r_in);
//        begin
//          @(negedge CLK);
//          S = s_in;
//          R = r_in;
//        end
//    endtask
    
//      task din_d(input d_in);
//        begin
//          @(negedge CLK);
//          D = d_in;
//        end
//    endtask

//      task din_jk(input j_in, input k_in);
//        begin
//          @(negedge CLK);
//          J = j_in;
//          K = k_in;
//          @(posedge CLK);
//        end
//    endtask

    task din_d(input d_in);
        begin
          @(negedge CLK);
          T = d_in;
          @(posedge CLK);
        end
    endtask

    initial begin
    RST = 1;
    @(posedge CLK);
    RST = 0;
    @(posedge CLK)
    din_d(1);
    din_d(0);
    din_d(1);
    #20;
    $finish;
    end
    
endmodule
