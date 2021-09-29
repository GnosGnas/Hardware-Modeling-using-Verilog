module adder_rom_2bit (Cout, Sum, A, B, C);
	input [1:0] A, B;
	input C;
	output [1:0] Sum;
	output Cout;
	reg [2:0] rom[31:0];
	
	reg [5:0] i;
	
	assign {Cout, Sum} = rom[{A,B,C}];
	
	initial begin
		for ( i = 0; i <= 31; i = i+ 1 ) begin
			rom[i[4:0]] = i[4:3] + i[2:1] + i[0]; 
		end
	end
endmodule	