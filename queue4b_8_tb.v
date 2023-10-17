`include "queue4b_8.v"

module queue4b_8_tb;
    reg clk, rstn, en, push_pop;
    reg [3:0] Din;
    wire isFull, isEmpty;
    wire [3:0] Dout;

    queue4b_8 que(
        .clk(clk),
        .rstn(rstn),
        .en(en),
        .push_pop(push_pop),
        .Din(Din),
        .isFull(isFull),
        .isEmpty(isEmpty),
        .Dout(Dout)
    );

    parameter CYCLE = 2;
    always begin
        clk=0; #(CYCLE/2);
        clk=1; #(CYCLE/2);
    end

    always @(negedge clk) begin
        Din <= {$random}%16;
    end

    initial begin
        $dumpfile("queue4b_8_tb.vcd");
        $dumpvars(0, que);
        en=0; push_pop=0; rstn=0; #(CYCLE*3);
        en=1; push_pop=1; rstn=1; #(CYCLE*5);
        en=0;                     #(CYCLE*3);
        en=1;                     #(CYCLE*5);
        en=0; push_pop=0;         #(CYCLE*3);
        en=1;                     #(CYCLE*5);
        en=0;                     #(CYCLE*5);
        $finish;
    end

endmodule