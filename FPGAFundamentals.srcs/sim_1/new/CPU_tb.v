`timescale 1ns / 1ps

module cpu_tb;

    reg clk;
    reg rst;
    wire [7:0] pc_out;
    wire [7:0] reg_read_data1;
    wire [7:0] reg_read_data2;
    
    CPU uut(
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out),
        .reg_read_data1(reg_read_data1),
        .reg_read_data2(reg_read_data2)
    );

    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        rst = 1;
        #15;              
        rst = 0;
    end
        integer cycles;
    initial begin
        for (cycles = 0; cycles < 50; cycles = cycles + 1) begin
            @(posedge clk);
        end
        $finish;
    end

endmodule
