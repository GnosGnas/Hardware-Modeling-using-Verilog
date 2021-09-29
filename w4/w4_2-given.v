module bcdencoder (out, in, enable);
	input [9:0] in;
	input enable;
	output [3:0] out;
	reg [3:0] out;
	
	always @( in ) begin
		     if ( in[0] == 1 & enable == 1) out = 4'b0000;
		else if ( in[1] == 1 & enable == 1) out = 4'b0001;
		else if ( in[2] == 1 & enable == 1) out = 4'b0010;
		else if ( in[3] == 1 & enable == 1) out = 4'b0011;
		else if ( in[4] == 1 & enable == 1) out = 4'b0100;
		else if ( in[5] == 1 & enable == 1) out = 4'b0101;
		else if ( in[6] == 1 & enable == 1) out = 4'b0110;
		else if ( in[7] == 1 & enable == 1) out = 4'b0111;
		else if ( in[8] == 1 & enable == 1) out = 4'b1000;
		else if ( in[9] == 1 & enable == 1) out = 4'b1001;
		else 	 			    out = 4'bxxxx;
	end
endmodule