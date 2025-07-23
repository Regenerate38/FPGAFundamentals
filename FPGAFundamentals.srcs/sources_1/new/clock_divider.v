`timescale 1ns / 1ps

module clock_divider_half(
    input CLK,
    input RST,
    output Q
);
    wire internal;
    d_flipflop d1(
        .CLK(CLK), .RST(RST), .Q(Q), .D(internal), .Q_bar(internal)
    );
    
endmodule

module clock_divider #(
    parameter N = 4
)(
    input CLK,
    input RST,
    output Q
);
    wire [N-1:0] q;
    wire [N-1:0] q_bar;
    genvar i;
    generate
        for (i=0; i<N; i=i+1) begin: ff_chain
            if (i == 0) begin
                d_flipflop d (
                    .CLK(CLK), .RST(RST), .D(q_bar[i]), .Q(q[i]), .Q_bar(q_bar[i])
                );
            end
            else begin
                d_flipflop dff (
                    .CLK(q[i-1]), .RST(RST), .D(q_bar[i]), .Q(q[i]), .Q_bar(q_bar[i])
                );
            end
        end
    endgenerate
    assign Q =q[3];

endmodule