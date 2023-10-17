`include "FA.v"

module full_adder_tb;
	reg   a, b, cin;
	wire  cout, sum;

	full_adder FA( a, b, cin, cout, sum );

	initial
		begin
			$dumpfile("FA_tb.vcd");
			$dumpvars(0, FA);
			$monitor("a = %b, b = %b cin = %b | cout = %b sum = %b ", a, b, cin, cout, sum);
			#50;
			a=1'b0; b=1'b0; cin=1'b0; #50;
			a=1'b0; b=1'b1; cin=1'b0; #50;
			a=1'b1; b=1'b0; cin=1'b0; #50;
			a=1'b1; b=1'b1; cin=1'b0; #50;
			a=1'b0; b=1'b0; cin=1'b1; #50;
			a=1'b0; b=1'b1; cin=1'b1; #50;
			a=1'b1; b=1'b0; cin=1'b1; #50;
			a=1'b1; b=1'b1; cin=1'b1; #50;
			$finish;
		end
endmodule