`timescale 10ns/1ns
`include "MUX4to1.v"

module MUX4to1_tb;
    reg [3:0] Din;
    reg [1:0] sel;
    wire Dout;

    MUX4to1 mux421(.Din(Din),
                   .sel(sel),
                   .Dout(Dout));

    task go_thru_Din;
        for (integer i=0; i<16; i=i+1) begin
            Din = i; #1;
        end
    endtask

    initial begin
        $dumpfile("MUX4to1_tb.vcd");
		$dumpvars(0, mux421);
        sel = 2'b00; go_thru_Din;
        sel = 2'b01; go_thru_Din;
        sel = 2'b10; go_thru_Din;
        sel = 2'b11; go_thru_Din;
        $finish;
    end
endmodule