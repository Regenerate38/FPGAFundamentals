`timescale 1ns / 1ps

module param_encoder #(
    parameter WIDTH = 4
    )(
        input wire [WIDTH-1:0] ips,
        output reg [$clog2(WIDTH)-1:0] out
    );
        integer i;
        reg Break;
        always @(*) begin //SystemVerilog apparently has always_comb
            out = 0;
            Break = 1'b0;
            for (i=0; i<WIDTH; i=i+1) begin
                if (ips[i]==1'b1 && !Break) begin
                    out = i;   // I am stupid. 
                    Break = 1'b1;   // Verilog 2001 doesn't have break statement
                end
            end
        end 
   
endmodule
