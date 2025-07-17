`timescale 1ns / 1ps


// Verilog doesn't support multi-dimensional arrays as ports in Verilog Module??? WTH???
module param_mux #(
    parameter S_SIZE = 4
) (
    input wire [2**S_SIZE-1:0] ips,
    output reg out,
    input wire [S_SIZE-1:0] sel
    );
    
    always @(*) begin //  workaround to assign to non-net value. 
               // The value is continuously being added to reg
    assign out = ips[sel]; //while assign is for between net values, not much difference in this case.
    end
    
endmodule


