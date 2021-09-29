module dff(q, d, clk, rst);
  input d, clk, rst;
  output reg q;

  always @(posedge clk) begin
    if (rst==1'b1) q <= 1'b0;
    else q <= d;
  end
endmodule