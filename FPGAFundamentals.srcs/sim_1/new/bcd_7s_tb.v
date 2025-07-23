`timescale 1ns / 1ps

module bcd_7s_tb;
    reg [3:0] bcd_in;
    reg CLK;
    reg mode;
    wire [6:0] out;
    
    bcd_7s uut (
        .bcd_in(bcd_in), .CLK(CLK), .mode(mode), .out(out)
    );
    
    initial CLK = 1;
    always #5 CLK = ~CLK;
    integer i;
    initial begin
        mode = 1;
        bcd_in = 4'b0000;
        for (i=0; i<9; i=i+1) begin
            @(posedge CLK);
            bcd_in = bcd_in + 4'b0001;
        end
        @(posedge CLK);
        $finish;
    end
endmodule
