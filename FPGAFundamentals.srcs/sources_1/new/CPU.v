`timescale 1ns / 1ps

module CPU(
    input clk,
    input rst,
    output [7:0] pc_out,
    output [7:0] reg_read_data1,
    output [7:0] reg_read_data2
);

    wire [7:0] instruction;
    wire [7:0] instr_reg_out;
    wire [3:0] alu_op;
    wire reg_write_en;
    wire [7:0] reg_write_addr;
    wire [7:0] reg_read_addr1;
    wire [7:0] reg_read_addr2;
    wire pc_enable;
    wire pc_inc;
    wire [7:0] jmp_addr;
    wire [7:0] imm_value;
    wire [1:0] state;
    wire [7:0] alu_result;
    wire alu_cout;
    wire alu_zero;
    wire alu_neg;
    wire status_load;

    reg [7:0] writeback_data;
    reg [7:0] latched_imm;

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

    instru_reg ir_inst(
        .instru_out(instr_reg_out),
        .clk(clk),
        .rst(rst),
        .load_enable(1'b1),
        .instru_in(instruction)
    );

    control_unit cu_inst(
        .clk(clk),
        .rst(rst),
        .instruction(instr_reg_out),
        .alu_op(alu_op),
        .reg_write_en(reg_write_en),
        .reg_write_addr(reg_write_addr),
        .reg_read_addr1(reg_read_addr1),
        .reg_read_addr2(reg_read_addr2),
        .pc_enable(pc_enable),
        .pc_inc(pc_inc),
        .jmp_addr(jmp_addr),
        .imm_value(imm_value),
        .state(state)
    );

    always @(posedge clk or posedge rst) begin
        if (rst)
            latched_imm <= 8'b0;
        else if (state == 2'b10)
            latched_imm <= imm_value;
    end

    always @(*) begin
        if (state == 2'b11 && (latched_imm != 8'b0))
            writeback_data = latched_imm;
        else
            writeback_data = alu_result;
    end

    reg_file rf_inst(
        .clk(clk),
        .reg_write_en(reg_write_en),
        .reg_write_addr(reg_write_addr),
        .reg_write_data(writeback_data),
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

    assign status_load = (state == 2'b11);

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
