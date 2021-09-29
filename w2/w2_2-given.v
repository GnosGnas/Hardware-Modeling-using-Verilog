
module half_adder (S, C, X, Y);
	input X, Y;
	output S, C;

    and G1 (C, X, Y);
	xor G2 (S, X, Y);
endmodule
module full_adder_2bit (Sum, Carry, A, B, Cin);
	input [1:0] A, B;
	input Cin;
	output [1:0] Sum;
	output Carry;
	
	wire ts1, tc1, tc2, tc3, tc4, tcarry;

	half_adder H1 (ts1, tc1, A[0], B[0]);
	half_adder H2 (Sum[0], tc2, ts1, Cin);
        or O1 (tcarry, tc1, tc2); 
	half_adder H3 (ts2, tc3, A[1], B[1]);
	half_adder H4 (Sum[1], tc4, ts2, tcarry);
        or O2 (Carry, tc3, tc4);
endmodule