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
    for (i = 0; i <= 32; i = i + 1) begin
        mem_data[i] = i[7:0]; 
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