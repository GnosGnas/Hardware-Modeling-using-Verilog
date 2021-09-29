module buttonpressevent (e, y, clk);
	input y, clk;
	output e;
	reg e, PS, NS;
	
	parameter A = 0, B = 1;
	parameter RINGING = 0, NOTRINGING = 1;
	
	always @(posedge clk)
		PS <= NS;
		
	always @(PS, y) 
		case (PS)
			A: begin
				e = y ? RINGING : NOTRINGING;
				NS = y ? A : B;
			   end
			B: begin
				e = y ? NOTRINGING : RINGING;
				NS = y ? A : B;
			   end
			default: begin
				    e = 0; NS = A;
				 end
        endcase			   
endmodule