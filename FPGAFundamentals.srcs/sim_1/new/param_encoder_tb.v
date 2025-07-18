`timescale 1ns / 1ps

module param_encoder_tb;
    reg [3:0] ips;
    wire [1:0] out;
    
    param_encoder #(
        .WIDTH(4)
    ) uut (
        .ips(ips),
        .out(out)
    );
    
    initial begin;
            ips =  4'b0001;     
            #20;
            ips =  4'b0010;     
            #20;
            ips =  4'b0100;     
            #20;
            ips =  4'b1000;     
            #20;
            $finish;
        
    end
endmodule
