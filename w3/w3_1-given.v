module dff (q, d, clk, rst);
	input d, clk, rst;
	output q;
	reg q;

	always @ (posedge clk) begin
		if (rst) q <= 1'b0;
		else     q <= d;
	end
endmodule