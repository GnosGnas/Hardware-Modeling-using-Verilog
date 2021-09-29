//sample solution
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
module pipe_adder_8bit (Cout, Sum, X, Y, Cin, Clk);
	input [7 : 0] X, Y;
	input Cin, Clk;
	output [7 : 0] Sum;
	output Cout;
	reg [7 : 0] Sum;
	reg Cout;
	
	reg [16:0] stage1;
	reg [14:0] stage2;
	reg [12:0] stage3;
	reg [10:0] stage4;
	
	wire [2:0] stage1sc;
	wire [2:0] stage2sc;
	wire [2:0] stage3sc;
	wire [2:0] stage4sc;
	
	adder_rom_2bit A1 (stage1sc[2], stage1sc[1:0], stage1[10:9], stage1[2:1], stage1[0]);
	adder_rom_2bit A2 (stage2sc[2], stage2sc[1:0], stage2[10:9], stage2[4:3], stage2[2]);
	adder_rom_2bit A3 (stage3sc[2], stage3sc[1:0], stage3[10:9], stage3[6:5], stage3[4]);
	adder_rom_2bit A4 (stage4sc[2], stage4sc[1:0], stage4[10:9], stage4[8:7], stage4[6]);
	
	always @ (posedge Clk) begin
			stage1 <= {X, Y, Cin};
			stage2 <= {stage1[16: 11], stage1[8:3], stage1sc[2:0]};
			stage3 <= {stage2[14: 11], stage2[8:5], stage2sc[2:0], stage2[1:0]};
			stage4 <= {stage3[12: 11], stage3[8:7], stage3sc[2:0], stage3[3:0]};
			{Cout, Sum} <= {stage4sc[2:0], stage4[5:0]};
	end
endmodule	