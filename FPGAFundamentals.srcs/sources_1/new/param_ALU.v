`timescale 1ns / 1ps

// not doing Multiplication and Division cuz not even 8085 has it. 

module param_ALU #(
    parameter WIDTH = 8
) (
    output  [WIDTH-1:0] Out,
    output reg C_out,
    output reg Zero,
    //output reg Overflow,
    output reg Negative,
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [3:0] sel
   // input wire CLK    
    );
    reg [WIDTH-1:0] logic_result;
    reg [WIDTH:0] arith_result;
    
    reg temp1;
    reg temp2;
    
    always @(*) begin
    
        Zero = 1'b0;
        //Overflow = 1'b0;
        Negative = 1'b0;
        C_out = 1'b0;
        logic_result = 0;
        arith_result = 0;
            
    case (sel)
    4'b0000: begin // ADD
                 arith_result = A+B;
                 C_out = arith_result[WIDTH];
                 Negative = arith_result[WIDTH-1];
                 Zero = (arith_result[WIDTH-1:0]==0);
             end
    4'b0001: begin   // SUB
                 arith_result = A-B;
                 C_out = arith_result[WIDTH];
                 Negative = arith_result[WIDTH-1];
                 Zero = (arith_result[WIDTH-1:0]==0);
             end
    4'b0010: begin // SAL AX, 3
                 logic_result= (A << B); // 3 is stored in B
                 end
    4'b0011: begin 
                if (B == 0) 
                    logic_result = A;
                else if (B >= WIDTH) 
                    logic_result = {WIDTH{A[WIDTH-1]}};
                else 
                    logic_result = (A >> B) | ({WIDTH{A[WIDTH-1]}} << (WIDTH-B)); // sign extend garna
            end
    4'b0100: logic_result = A & B; // AND   
    4'b0101: logic_result = A | B; // OR
    4'b0110: logic_result = ~A; // NOT  
    4'b0111: logic_result = A ^ B; // XOR
    4'b1000: logic_result = (A << B); // Logical Shift Left
    4'b1001: logic_result = (A >> B); // Logical Shift Right
    default: begin
                 logic_result = 0;
                 arith_result = 0;
             end         
    endcase
    end
    assign Out = (sel == 4'b0000 || sel == 4'b0001) ? arith_result[WIDTH-1:0] : logic_result;
    
endmodule
