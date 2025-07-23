`timescale 1ns / 1ps

module bcd_7s(
        input wire [3:0] bcd_in, // D, C, B, A
        input wire mode, // 1 for CC conf, 0 for CA
        input wire CLK,
        output reg [6:0] out // a, b, c, d, e, f, g
    );
    
    always @(*) begin
        case(mode)
            1'b1: case(bcd_in)
                    4'b0000: out <= 7'h3F;
                    4'b0001: out <= 7'h06;
                    4'b0010: out <= 7'h5B;
                    4'b0011: out <= 7'h4F;
                    4'b0100: out <= 7'h66;
                    4'b0101: out <= 7'h6D;
                    4'b0110: out <= 7'h7D;
                    4'b0111: out <= 7'h07;
                    4'b1000: out <= 7'h7F;
                    4'b1001: out <= 7'h6F;
                    default: out <= 7'h00;
                  endcase
             1'b0: case(bcd_in)
                    4'b0000: out <= 7'h40; 
                    4'b0001: out <= 7'h79; 
                    4'b0010: out <= 7'h24; 
                    4'b0011: out <= 7'h30; 
                    4'b0100: out <= 7'h19; 
                    4'b0101: out <= 7'h12; 
                    4'b0110: out <= 7'h02; 
                    4'b0111: out <= 7'h78; 
                    4'b1000: out <= 7'h00; 
                    4'b1001: out <= 7'h10; 
                    default: out <= 7'h7F;           
                   endcase  
        endcase
    end
endmodule
