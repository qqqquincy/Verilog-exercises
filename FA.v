module full_adder(a, b, cin, cout, sum);
	input	a, b, cin;
	output	cout, sum;

	assign	{ cout, sum } = a + b + cin;
endmodule