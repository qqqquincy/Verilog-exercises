`timescale 10ns/1ns
`include "MUX2to1.v"

module MUX2to1_tb;
    reg sel, p0, p1;
    wire out;

    MUX2to1 mux221(
        .sel(sel),
        .p0(p0),
        .p1(p1),
        .out(out));

    initial begin
        $dumpfile("MUX2to1_tb.vcd");
		$dumpvars(0, mux221);
        #1;
        p0=1'b0; p1=1'b0; sel=1'b0; #1;
        p0=1'b0; p1=1'b0; sel=1'b1; #1;
        p0=1'b0; p1=1'b1; sel=1'b0; #1;
        p0=1'b0; p1=1'b1; sel=1'b1; #1;
        p0=1'b1; p1=1'b0; sel=1'b0; #1;
        p0=1'b1; p1=1'b0; sel=1'b1; #1;
        p0=1'b1; p1=1'b1; sel=1'b0; #1;
        p0=1'b1; p1=1'b1; sel=1'b1; #1;
        $finish;
    end
endmodule