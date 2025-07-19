`timescale 1ns / 1ps

module reg_file(
     input clk,
     input reg_write_en,
     input [7:0] reg_write_addr,
     input [7:0] reg_write_data,
     input [7:0] reg_read_addr1, 
     input [7:0] reg_read_addr2,
     output [7:0] reg_read_data1,
     output [7:0] reg_read_data2
    );

    reg [7:0] reg_data [0:3];
    
    // Reset on Init
    integer i;
    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            reg_data[i] = 8'b0;
        end
    end
    
    assign reg_read_data1 = reg_data[reg_read_addr1[1:0]];
    assign reg_read_data2 = reg_data[reg_read_addr2[1:0]];
    
    always @(posedge clk) begin
        if (reg_write_en) begin
            reg_data[reg_write_addr[1:0]] <= reg_write_data;
        end
    
    end
endmodule
