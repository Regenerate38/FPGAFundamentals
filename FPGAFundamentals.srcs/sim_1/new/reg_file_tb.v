`timescale 1ns / 1ps

module reg_file_tb();

    reg clk;
    reg reg_write_en;
    reg [7:0] reg_write_addr;
    reg [7:0] reg_write_data;
    reg [7:0] reg_read_addr1;
    reg [7:0] reg_read_addr2;
    wire [7:0] reg_read_data1;
    wire [7:0] reg_read_data2;

    reg_file uut (
        .clk(clk),
        .reg_write_en(reg_write_en),
        .reg_write_addr(reg_write_addr),
        .reg_write_data(reg_write_data),
        .reg_read_addr1(reg_read_addr1),
        .reg_read_addr2(reg_read_addr2),
        .reg_read_data1(reg_read_data1),
        .reg_read_data2(reg_read_data2)
    );

    
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reg_write_en = 0;
        reg_write_addr = 0;
        reg_write_data = 0;
        reg_read_addr1 = 0;
        reg_read_addr2 = 0;

        
        #10;

        reg_write_en = 1;
        @(posedge clk);
        reg_write_data = 8'hAA;
        reg_write_addr = 8'h00;
        @(posedge clk);

        reg_write_addr = 8'h01;
        reg_write_data = 8'hBB;
        @(posedge clk);

        reg_write_en = 0;
        @(posedge clk);


        reg_read_addr1 = 8'h00;
        reg_read_addr2 = 8'h01;
        #20;     

        $finish;
    end

endmodule
