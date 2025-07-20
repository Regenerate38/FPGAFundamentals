`timescale 1ns / 1ps

module seq_detector(
    input wire x, 
    input wire clk, 
    input wire rst, 
    output reg z
    );
    
    reg [1:0] state;
    reg [1:0] next_state;
    localparam Si = 2'b00,
               S0 = 2'b01,
               S01 = 2'b10,
               S010 = 2'b11;
    always @(posedge clk or posedge rst) begin
    if (rst) begin
        state = 0;
    end
        else state <= next_state;
    end
    
    always @(state or x) begin
        case(state)
            Si: if (x) next_state <= state;
                else next_state <= S0;
            S0: if (x) next_state <= S01 ;
                else next_state = S0;        
            S01: if (x) next_state <= Si ;
                else next_state <= S010;
            S010: if(x) begin
                    z=1;
                    next_state = 01;
             end
                    else next_state <= S0;
            default: next_state <= Si;
        endcase
    end
    
endmodule
