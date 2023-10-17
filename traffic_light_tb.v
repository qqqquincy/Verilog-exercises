`include "traffic_light.v"

module traffic_ligt_tb;
    reg clk, rstn;
    wire [2:0] lightA, lightB;

    parameter CYCLE = 2;
    always begin
        clk=0; #(CYCLE/2);
        clk=1; #(CYCLE/2);
    end

    traffic_light TL(
        .clk(clk),
        .rstn(rstn),
        .lightA(lightA),
        .lightB(lightB));

    initial begin
        $dumpfile("traffic_ligt_tb.vcd");
        $dumpvars(0, TL);
        rstn = 0;
        #(2*CYCLE);
        rstn = 1;
        #(100*CYCLE);
        $finish;
    end
endmodule