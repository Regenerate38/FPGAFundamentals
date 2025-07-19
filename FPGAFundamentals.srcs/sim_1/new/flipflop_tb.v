`timescale 1ns / 1ps

module flipflop_tb;
    reg S, R;
    
    reg CLK;
    initial CLK = 0;
    always #5 CLK = ~CLK;
    
    wire Q, Q_bar;
    sr_flipflop uut (
        .S(S), .R(R), .CLK(CLK), .Q(Q), .Q_bar(Q_bar)
    );
    
    task din(input s_in, input r_in);
        begin
          @(negedge CLK);
          S = s_in;
          R = r_in;
        end
    endtask
    
    task rst(input x);
    begin
    end
    endtask
    
    initial begin
    S = 0; R = 0; 
    din(0, 0);  // INVALID since NAND based Flipflop
    din(0, 1);  //RESET
    din(1, 0);  //SET
    din(1, 1);  // MEMORY
    din(1, 0);
    din(0, 0);
    din(0, 1);
    din(1, 1);  
    din(0, 1);
    #20;
    $finish;
    end
    
endmodule
