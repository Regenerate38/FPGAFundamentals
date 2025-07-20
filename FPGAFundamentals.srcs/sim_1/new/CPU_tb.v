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
   $display("time=%0t state=%b reg_write_en=%b reg_write_addr_for_writeback=%h loadi_in_flight=%b loadi_dest_reg=%h alu_mov_dest_reg=%h instr_reg_out=%h", $time, uut.state, uut.reg_write_en, uut.write_addr_for_writeback, uut.loadi_in_flight, uut.loadi_dest_reg, uut.alu_mov_dest_reg, uut.instr_reg_out);
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
