
module half_adder (S, C, X, Y);
	input X, Y;
	output S, C;

    and G1 (C, X, Y);
	xor G2 (S, X, Y);
endmodule