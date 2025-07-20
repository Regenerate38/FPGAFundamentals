`timescale 1ns / 1ps

module program_counter(
    input clk,
    input rst, 
    input pc_enable,
    input pc_inc,
    input [7:0] jmp_addr, // limits to 256 but makes some logic simple
    output reg [7:0] instru_addr
    );
    
    always @(posedge clk) begin
     if (rst) begin
        instru_addr <= 8'h00;
        end
     else if (pc_enable) begin
            instru_addr <= jmp_addr;
     end
     else if (pc_inc) instru_addr <= instru_addr + 8'h01;
     else begin
            instru_addr <= instru_addr; // hold value
        end
    end
endmodule


module instru_mem(
    input [7:0] addr,
    output [7:0] instru
);
reg [7:0] mem_data[0:255];
integer i;

//initial $readmemh("memory.mem", mem_data);

 initial begin
        mem_data[0] = 8'b0110_0000; // LOADI R0, 
        mem_data[1] = 8'b0110_0011; // Immediate value 63
        mem_data[2] = 8'b0110_0100; // LOADI R1
        mem_data[3] = 8'b0001_1001; // 19
        mem_data[4] = 8'b0101_1000; // MOV R2, R0 R2 = 63
        mem_data[5] = 8'b0000_1001; // ADD R2, R1
        mem_data[6] = 8'b0001_1000; // SUB R2, R0
        mem_data[7] = 8'b0010_1001; // AND R2, R1
        mem_data[8] = 8'b0011_1000; // OR R2, R0
        mem_data[9] = 8'b0100_1001; // XOR R2, R1

        // Initialize remaining memory to zero
        for (i = 8; i < 256; i = i + 1) begin
            mem_data[i] = 8'b0;
        end
    end
 
assign instru = mem_data[addr];
endmodule


module instru_reg(
    output reg [7:0] instru_out,
    input clk,
    input rst,
    input load_enable,
    input [7:0] instru_in
);
    always @(posedge clk) begin
        if (rst) 
            instru_out <= 8'h00;
        else if (load_enable)
        instru_out <= instru_in;
    end
endmodule