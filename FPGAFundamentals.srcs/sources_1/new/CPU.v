`timescale 1ns / 1ps

module CPU(
    input clk,
    input rst,
    output [7:0] pc_out
);

    wire [7:0] instruction;
    wire [3:0] alu_op;
    wire reg_write_en;
    wire [7:0] reg_write_addr;
    wire [7:0] reg_read_addr1;
    wire [7:0] reg_read_addr2;
    wire pc_enable;
    wire pc_inc;
    wire [7:0] jmp_addr;
    wire [7:0] imm_value;

    wire [7:0] reg_read_data1;
    wire [7:0] reg_read_data2;
    wire [7:0] alu_result;

    wire alu_cout;
    wire alu_zero;
    wire alu_neg;
    wire status_load;

    program_counter pc_inst(
        .clk(clk),
        .rst(rst),
        .pc_enable(pc_enable),
        .pc_inc(pc_inc),
        .jmp_addr(jmp_addr),
        .instru_addr(pc_out)
    );

    instru_mem imem_inst(
        .addr(pc_out),
        .instru(instruction)
    );

    control_unit cu_inst(
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .alu_op(alu_op),
        .reg_write_en(reg_write_en),
        .reg_write_addr(reg_write_addr),
        .reg_read_addr1(reg_read_addr1),
        .reg_read_addr2(reg_read_addr2),
        .pc_enable(pc_enable),
        .pc_inc(pc_inc),
        .jmp_addr(jmp_addr),
        .imm_value(imm_value)
    );

    wire [7:0] reg_write_data = (cu_inst.state == 2'b10) ? imm_value : alu_result;

    reg_file rf_inst(
        .clk(clk),
        .reg_write_en(reg_write_en),
        .reg_write_addr(reg_write_addr),
        .reg_write_data(reg_write_data),
        .reg_read_addr1(reg_read_addr1),
        .reg_read_addr2(reg_read_addr2),
        .reg_read_data1(reg_read_data1),
        .reg_read_data2(reg_read_data2)
    );

    param_ALU #(.WIDTH(8)) alu_inst(
        .A(reg_read_data1),
        .B(reg_read_data2),
        .sel(alu_op),
        .Out(alu_result),
        .C_out(alu_cout),
        .Zero(alu_zero),
        .Negative(alu_neg)
    );

    status_register status_reg_inst(
        .clk(clk),
        .rst(rst),
        .load(status_load),
        .C_in(alu_cout),
        .Zero_in(alu_zero),
        .Negative_in(alu_neg),
        .C_out(),
        .Zero(),
        .Negative()
    );

    assign status_load = (cu_inst.state == 2'b11);

endmodule

module status_register(
    input clk,
    input rst,
    input load,
    input C_in,
    input Zero_in,
    input Negative_in,
    output reg C_out,
    output reg Zero,
    output reg Negative
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            C_out    <= 0;
            Zero     <= 0;
            Negative <= 0;
        end else if (load) begin
            C_out    <= C_in;
            Zero     <= Zero_in;
            Negative <= Negative_in;
        end
    end
endmodule
