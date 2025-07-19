`timescale 1ns/1ps

module instru_fetch_unit_tb();

    reg clk;
    reg rst;
    
    // For Program Counter
    reg pc_enable;
    reg pc_inc;
    reg [7:0] jmp_addr;
    wire [7:0] pc_addr;
    
    // for Instru mem
    wire [7:0] instru_mem_out;
    
    // Instruction register 
    reg load_enable;
    wire [7:0] instru_reg_out;
    
    program_counter pc_inst (
        .clk(clk),
        .rst(rst),
        .pc_enable(pc_enable),
        .pc_inc(pc_inc),
        .jmp_addr(jmp_addr),
        .instru_addr(pc_addr)
    );
    
    instru_mem mem_inst (
        .addr(pc_addr),
        .instru(instru_mem_out)
    );
    
    instru_reg ir_inst (
        .clk(clk),
        .rst(rst),
        .load_enable(load_enable),
        .instru_in(instru_mem_out),
        .instru_out(instru_reg_out)
    );
    

    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        @(posedge clk);
        rst = 1;
        pc_enable = 0;
        jmp_addr = 8'h00;
        load_enable = 0;
        
        // Checking Instru Fetch Pipeline
        @(posedge clk);
        rst = 0;

        @(posedge clk);
        pc_enable = 0;        
        jmp_addr = 8'h00;     
        load_enable = 0;
        
        repeat(3) begin
            @(posedge clk);
            pc_inc = 1;
            load_enable = 1;
        end
        
        load_enable = 0; 
        
        // Testing JMP
        @(posedge clk);
        pc_enable = 1;
        jmp_addr = 8'h10;
        load_enable = 1;      
        
        @(posedge clk);
        pc_enable = 0;        
        jmp_addr = 8'h00;     
        load_enable = 1;
        
        // Incrementing 3 after JMP
        repeat(3) begin
            @(posedge clk);
            pc_inc = 1;
            load_enable = 1;
        end
        
        #10;
        $finish;
    end
endmodule
