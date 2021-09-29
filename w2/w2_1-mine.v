
module half_adder (S, C, X, Y);
  	input X, Y;
  	output S, C;
  	reg S;
  	reg C;
  	
  	always
      begin
       #5 S <= X^Y;
        C <= X&Y;
      end
endmodule