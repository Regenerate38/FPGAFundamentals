`timescale 1ns / 1ps

module uart(
        input wire [7:0] data,
        output reg INT,
        input wire GND,
        input wire CLK,
        input wire Rx,
        output reg Tx,
        input wire RTS,
        output reg CTS,
        output reg DTR, // active HIGH for this case
        input wire DSR,
        input wire tx_ready,
        output wire [7:0] received_data
    );
    reg [7:0] received;
    initial DTR <= 1;
    reg busy;
    reg rx_d1, rx_d2;
    integer i = 0;
    integer j = 0;
    assign received_data = received;
    initial busy = 0;
    // Receiving Part
    always @(posedge CLK) begin    
        if (DSR) begin
            CTS = 1;
            if (busy==0) begin
                rx_d2 = rx_d1;   
                rx_d1 = Rx;
                if (rx_d2 == 1'b1 && rx_d1 == 1'b0) begin
                    busy = 1;
                end
            end
            if (busy==1) begin
                rx_d2 = rx_d1;  
                rx_d1 = Rx;
                if ((rx_d2 ==1'b0||rx_d2 == 1'b1 )  && rx_d1 == 1'b0) begin
                   received[i] =rx_d2;
                   i = i + 1;
                end
               if (i==8) begin
                    i = 0;
                    busy = 0;
                    INT = 1;
               end
            end
            
        end
    end
    
    // Sending Part
    always @(posedge CLK) begin
        if (DSR && tx_ready)begin
            if (RTS) begin
                Tx = 1;
                @(posedge CLK);
                Tx = 0;
                @(posedge CLK);
                for (i=0; i<8; i=i+1) begin
                    Tx = data[i];
                    @(posedge CLK);
                    Tx = 0;
                    @(posedge CLK);
                end
            end
        end
    end
endmodule
