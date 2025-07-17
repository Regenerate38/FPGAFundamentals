`timescale 1ns / 1ps

module param_mux_tb;
    
    reg [15:0] ips;
    reg [3:0] sel;
    wire out;

    param_mux #(
       .S_SIZE(4)
    ) uut (
    .ips(ips),
    .sel(sel),
    .out(out)
    );
    // When using parameterized instantiation
    // use the instance name (uut, etc) AFTER PARAMETERS SECTION

    integer i;
    initial begin;
    
    ips = 16'b1010110111110011;
    
    for(i=0; i<15; i=i+1) 
    begin
        sel = i;
        #20; 
    end
    $finish;
end
endmodule
