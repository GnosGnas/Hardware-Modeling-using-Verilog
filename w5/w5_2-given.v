module timercontroller (x, b, clk);
	input b, clk;
	output x;
	reg x;
	reg [1:0] PS;
	
	parameter OFF = 0, ON1 = 1, ON2 = 2, ON3 = 3;
	parameter NOTILLUMINATING = 0, ILLUMINATING = 1;
	
	always @(posedge clk)
		case (PS)
			OFF: PS <= b ? ON1 : OFF;
			ON1: PS <= ON2;
			ON2: PS <= ON3;
			ON3: PS <= OFF;
			default: PS <= OFF;
		endcase
	always @(PS)
		case (PS)
			OFF: x = NOTILLUMINATING;
			ON1, ON2, ON3: x = ILLUMINATING;
		endcase
endmodule