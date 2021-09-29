module dff (q, d, clk, rst);
	input d, clk, rst;
	output q;
	reg q;

	always @ (posedge clk) begin
		if (rst) q <= 1'b0;
		else     q <= d;
	end
endmodule

module reg8bit (out, in, clk, ld, asr, lsl, clr);
  input [7:0] in;
  input clk, ld, asr, lsl, clr;
  output [7:0] out;
  wire [7:0] t;
  
  assign t[7] = ld ? in[7] : asr ? out[7] : lsl ? out[6] : out[7];
  assign t[6] = ld ? in[6] : asr ? out[7] : lsl ? out[5] : out[6];
  assign t[5] = ld ? in[5] : asr ? out[6] : lsl ? out[4] : out[5];
  assign t[4] = ld ? in[4] : asr ? out[5] : lsl ? out[3] : out[4];
  assign t[3] = ld ? in[3] : asr ? out[4] : lsl ? out[2] : out[3];
  assign t[2] = ld ? in[2] : asr ? out[3] : lsl ? out[1] : out[2];
  assign t[1] = ld ? in[1] : asr ? out[2] : lsl ? out[0] : out[1];
  assign t[0] = ld ? in[0] : asr ? out[1] : lsl ? 1'b0   : out[0];
  
  dff D7 (out[7], t[7], clk, clr);
  dff D6 (out[6], t[6], clk, clr);
  dff D5 (out[5], t[5], clk, clr);
  dff D4 (out[4], t[4], clk, clr);
  dff D3 (out[3], t[3], clk, clr);
  dff D2 (out[2], t[2], clk, clr);
  dff D1 (out[1], t[1], clk, clr);
  dff D0 (out[0], t[0], clk, clr);
  
endmodule
