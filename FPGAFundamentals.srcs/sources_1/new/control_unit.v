`timescale 1ns / 1ps

module control_unit(
        output reg [3:0] alu_op,
        output reg reg_write_en, 
        output reg [7:0]reg_write_addr, 
        output reg [7:0]reg_read_addr1, 
        output reg [7:0] reg_read_addr2, 
        output reg pc_enable, 
        output reg pc_inc, 
        output reg [7:0] jmp_addr,
        output reg [7:0] imm_value,
        input [7:0] instruction,
        input rst,
        input clk
    );

    reg [1:0] state, next_state;
   // FETCH=00 , DECODE & EXECUTE=01, WRITE RESULT=10
    always @(posedge clk or posedge rst) begin
    if (rst) 
        state <= 2'b00;
    else
        state <= next_state;
    end
    
    always @(*) begin

        reg_write_en = 0;
        pc_inc = 0;
        alu_op = 4'b0000;
        
        case(state)
            //FETCH
            2'b00: begin
                // having all values idle/resetted
                alu_op = 4'b0000;
                reg_write_en = 0;           
                reg_write_addr = 8'b0;      
                reg_read_addr1 = 8'b0;      
                reg_read_addr2 = 8'b0;
                pc_enable = 0;              
                jmp_addr = 8'b0;
                pc_inc = 1;                 
    
                next_state = 2'b01;
            end

            //DECODE and EXECUTE
            2'b01: begin
                case(instruction[7:4])
                   4'b0000: begin // ADD RD, RS
                        reg_read_addr1 = {6'b0, instruction[3:2]};
                        reg_read_addr2 = {6'b0, instruction[1:0]};
                        alu_op = 4'b0000;
                        reg_write_addr = {6'b0, instruction[3:2]};
                        next_state = 2'b11;
                   end
                   4'b0001: begin // SUB RD, RS
                        reg_read_addr1 = {6'b0, instruction[3:2]};
                        reg_read_addr2 = {6'b0, instruction[1:0]};
                        alu_op = 4'b0001;
                        reg_write_addr = {6'b0, instruction[3:2]};
                        next_state = 2'b11;
                   end
                   4'b0010: begin // AND RD, RS
                        reg_read_addr1 = {6'b0, instruction[3:2]};
                        reg_read_addr2 = {6'b0, instruction[1:0]};
                        alu_op = 4'b0100;
                        reg_write_addr = {6'b0, instruction[3:2]};
                        next_state = 2'b11;
                   end
                   4'b0011: begin // OR RD, RS
                        reg_read_addr1 = {6'b0, instruction[3:2]};
                        reg_read_addr2 = {6'b0, instruction[1:0]};
                        alu_op = 4'b0101;
                        reg_write_addr = {6'b0, instruction[3:2]};
                        next_state = 2'b11;
                   end
                   4'b0100: begin // XOR RD, RS
                        reg_read_addr1 = {6'b0, instruction[3:2]};
                        reg_read_addr2 = {6'b0, instruction[1:0]};
                        alu_op = 4'b0111;
                        reg_write_addr = {6'b0, instruction[3:2]};
                        next_state = 2'b11;
                   end
                   4'b0101: begin // MOV RD, RS
                        reg_read_addr1 = {6'b0, instruction[1:0]};
                        reg_write_addr = {6'b0, instruction[3:2]};
                        alu_op = 4'b0000; // Pass-through or add code if needed
                        next_state = 2'b11;
                   end                     
                  4'b0110: begin // LOADI RD, #imm
                        pc_inc = 1;
                        reg_write_addr = {6'b0, instruction[3:2]};
                        next_state = 2'b10;
                   end
                  
                  4'b0111: begin // JMP RD
                        pc_enable = 1;
                        jmp_addr = {6'b0, instruction[3:2]};
                        next_state = 2'b00;
                  end
                  
                  default: begin
                        next_state = 2'b00;
                  end
                endcase
            end
            
            // INDIRECT
            2'b10: begin
                imm_value = instruction;
                next_state = 2'b11;
            end
            //WRITE RESULT
            2'b11: begin
                reg_write_en = 1;
                pc_inc = 1;
                next_state = 2'b00;
            end 
            
            default: next_state = 2'b00;            
        endcase
    end
endmodule
