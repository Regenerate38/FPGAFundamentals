`timescale 1ns/1ps

module param_ALU_tb();

    parameter WIDTH = 8;
    
    reg [WIDTH-1:0] A, B;
    reg [3:0] sel;
    
    wire [WIDTH-1:0] Out;
    wire C_out;
    wire Zero;
    wire Negative;
    
    param_ALU #(WIDTH) uut (
        .Out(Out),
        .C_out(C_out),
        .Zero(Zero),
        .Negative(Negative),
        .A(A),
        .B(B),
        .sel(sel)
    );
    
    initial begin
        A = 8'h00;
        B = 8'h00;
        sel = 4'b0000;
                #10;
        
        // ADD: 5 + 10 = 15
        A = 8'd5; B = 8'd10; sel = 4'b0000;
        #10; 
        
        // ADD with carry: 200 + 100 = 44 (with carry out=1)
        A = 8'd200; B = 8'd100; sel = 4'b0000;
        #10;
        
        // SUB: 15 - 5 = 10
        A = 8'd15; B = 8'd5; sel = 4'b0001;
        #10;
        
        // SUB negative result: 5 - 15 = -10 (two's complement)
        A = 8'd5; B = 8'd15; sel = 4'b0001;
        #10;
        
        // Arithmetic Left Shift: 3 << 2 = 12
        A = 8'd3; B = 8'd2; sel = 4'b0010;
        #10;
        
        // Arithmetic Right Shift by 1: 0xF0 >> 1 = 0xF8 (sign extended)
        A = 8'hF0; B = 8'd1; sel = 4'b0011;
        #10; 
        
        // AND: 0xAA & 0x0F = 0x0A
        A = 8'hAA; B = 8'h0F; sel = 4'b0100;
        #10; 
        
        // OR: 0x55 | 0x0F = 0x5F
        A = 8'h55; B = 8'h0F; sel = 4'b0101;
        #10; 
        
        // NOT: ~0x0F = 0xF0
        A = 8'h0F; B = 8'd0; sel = 4'b0110;
        #10; 
        
        // XOR: 0xFF ^ 0x0F = 0xF0
        A = 8'hFF; B = 8'h0F; sel = 4'b0111;
        #10; 
        
        // Logical Left Shift: 0x0F << 2 = 0x3C
        A = 8'h0F; B = 8'd2; sel = 4'b1000;
        #10; 
        
        // Logical Right Shift: 0xF0 >> 3 = 0x1E
        A = 8'hF0; B = 8'd3; sel = 4'b1001;
        #10; 
        
        
        $finish;
    end

endmodule
