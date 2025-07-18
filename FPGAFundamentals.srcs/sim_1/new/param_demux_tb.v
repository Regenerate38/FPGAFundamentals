`timescale 1ns / 1ps

module param_demux_tb;

    reg I;
    reg [1:0] sel ;
    wire [3:0] data;
    
    param_demux #(
        .sel_width(2)) 
        uut  (
        .I(I), 
        .sel(sel), 
        .data(data));
    integer i;
    initial begin
    I = 1;
    for (i=0; i<4 ; i = i+1) begin
        sel = i;
        #20;
    end
    #20;
    $finish;
    end
    
endmodule
