`timescale 1ns / 1ps

module param_decoder # (
    parameter N = 4
    )(
    input wire [N-1:0] ips,
    output wire [2**N-1:0] out 
    );
    assign out = 1 << ips; // Instead of always(*) 
                          //and requiring non-net (reg) for output
endmodule
