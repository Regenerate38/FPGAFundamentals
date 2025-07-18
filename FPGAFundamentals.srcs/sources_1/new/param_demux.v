`timescale 1ns / 1ps

module param_demux #(
    parameter sel_width = 2
)(
    input wire I,
    input wire [sel_width-1:0] sel,
    output reg [2**sel_width - 1:0] data
    );
    
    always @(*) begin
        data = 0; // Clearing to not hav inferred latching. 
                 // Issue had arisen after simulating testbench
        data[sel] = I; 
    end
endmodule
