`timescale 1ns / 1ps

module uart_tb;

    reg         clk;
    reg         rst;

    reg  [7:0]  uart1_data;
    wire        uart1_INT;
    wire        uart1_Tx;
//    reg         uart1_RTS;
    wire        uart1_CTS;
    wire        uart1_DTR;
//    wire         uart1_DSR;
    reg         uart1_tx_ready;
    wire [7:0]  uart1_received_data;

    reg  [7:0]  uart2_data;
    wire        uart2_INT;
    wire        uart2_Tx;
//    reg         uart2_RTS;
    wire        uart2_CTS;
    wire        uart2_DTR;
//    wire         uart2_DSR;
    reg         uart2_tx_ready;
    wire [7:0]  uart2_received_data;

    uart uart1 (
        .data(uart1_data),
        .INT(uart1_INT),
        .GND(1'b0),
        .CLK(clk),
        .Rx(uart2_Tx),       
        .Tx(uart1_Tx),
        .RTS(uart2_CTS),
        .CTS(uart1_CTS),
        .DTR(uart1_DTR),
        .DSR(uart2_DTR),
        .tx_ready(uart1_tx_ready),
        .received_data(uart1_received_data)
    );

    uart uart2 (
        .data(uart2_data),
        .INT(uart2_INT),
        .GND(1'b0),
        .CLK(clk),
        .Rx(uart1_Tx),       
        .Tx(uart2_Tx),
        .RTS(uart1_CTS),
        .CTS(uart2_CTS),
        .DTR(uart2_DTR),
        .DSR(uart1_DTR),
        .tx_ready(uart2_tx_ready),
        .received_data(uart2_received_data)
    );

   
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end




  

    initial begin
        uart1_data = 8'h00;
        uart2_data = 8'h00;

        #100;

        uart1_data = 8'hA5;
        uart1_tx_ready = 1;
//        uart1_RTS = 1;  
        
        #50000; 
        $stop;
    end
    
    always @(posedge clk) begin
        $display("At time %t, uart2.Rx = %b, uart2.received =%h, uart2.busy=%b uart2.rxd1=%b, uart2.rxd2=%b" , 
        $time, uart2.Rx, uart2.received, uart2.busy, uart2.rx_d1, uart2.rx_d2);
    end

endmodule
