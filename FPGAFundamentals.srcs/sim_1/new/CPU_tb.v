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
    
initial begin
    forever @(posedge clk) begin
   $display("time=%0t alu_op=%b alu_result=%b state=%b",$time, uut.alu_op, uut.alu_result, uut.state);
        $display("REGFILE: R0=%h R1=%h R2=%h R3=%h",
            uut.rf_inst.reg_data[0],
            uut.rf_inst.reg_data[1],
            uut.rf_inst.reg_data[2],
            uut.rf_inst.reg_data[3]
        );
    end
end
    
        integer cycles;
         initial begin
        for (cycles = 0; cycles < 60; cycles = cycles + 1) begin
             @(posedge clk);
        end

        $finish;
    end

endmodule
