`timescale 1ns / 1ps

module param_decoder_tb;
    reg [1:0] ips;
    wire [3:0] out;
    
    param_decoder #(
        .N(2)
    ) uut (
        .ips(ips),
        .out(out)
    );
    
    initial begin;
            ips =  2'b00;     
            #20;
            ips =  2'b01;     
            #20;
            ips =  2'b10;     
            #20;
            ips =  2'b11;     
            #20;
            $finish;
        
    end
    endmodule