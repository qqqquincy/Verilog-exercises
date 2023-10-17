`include "MUX2to1.v"

module MUX4to1(
    input [3:0] Din,
    input [1:0] sel,
    output Dout);

    wire m0_out;
    MUX2to1 m0(.p0(Din[0]),  // sel = 00, Dout = Din[0]
               .p1(Din[1]),  // sel = 01, Dout = Din[1]
               .sel(sel[0]),
               .out(m0_out));
    
    wire m1_out;
    MUX2to1 m1(.p0(Din[2]),  // sel = 10, Dout = Din[2]
               .p1(Din[3]),  // sel = 11, Dout = Din[3]
               .sel(sel[0]),
               .out(m1_out));

    MUX2to1 m2(.p0(m0_out),  // sel = 0x
               .p1(m1_out),  // sel = 1x
               .sel(sel[1]),
               .out(Dout));
    
endmodule