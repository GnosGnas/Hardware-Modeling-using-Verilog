module adder_rom_2bit (Cout, Sum, A,B,C);
  input [1:0] A, B;
  input C;
  output [1:0] Sum;
  output Cout;
  
  wire co;
  assign co = A[0]&B[0] | C&(A[0]|B[0]);
  assign Sum = A+B+{1'b0,C};
  assign Cout = A[1]&B[1] | co&(A[1]|B[1]);
endmodule

module pipe_adder_8bit (Cout, Sum, X, Y, Cin, Clk);
  input [7:0] X, Y;
  input Cin;
  input Clk;
  output Cout;
  output [7:0] Sum;
  
  //Stage 1
  reg [7:2] a1, b1;
  reg [1:0] sum1;
  reg c1;
  wire c1_wire;
  wire [1:0] sum1_wire;
  
  adder_rom_2bit add1(c1_wire, sum1_wire, X[1:0], Y[1:0], Cin);
  
  always@(posedge Clk)
    begin
      c1 <= c1_wire;
      sum1 <= sum1_wire;
      
      a1 <= X[7:2];
      b1 <= Y[7:2];
    end
  
  //Stage 2
  reg [7:4] a2, b2;
  reg [3:0] sum2;
  reg c2;
  wire c2_wire;
  wire [1:0] sum2_wire;
  
  adder_rom_2bit add2(c2_wire, sum2_wire, a1[3:2], b1[3:2], c1);
  
  always@(posedge Clk)
    begin
      c2 <= c2_wire;
      sum2 <= {sum2_wire, sum1};
      
      a2 <= a1[7:4];
      b2 <= b1[7:4];
    end
  
  //Stage 3
  reg [7:6] a3, b3;
  reg [5:0] sum3;
  reg c3;
  wire c3_wire;
  wire [1:0] sum3_wire;
  
  adder_rom_2bit add3(c3_wire, sum3_wire, a2[5:4], b2[5:4], c2);
  
  always@(posedge Clk)
    begin
      c3 <= c3_wire;
      sum3 <= {sum3_wire, sum2};
      
      a3 <= a2[7:6];
      b3 <= b2[7:6];
    end
  
  //Stage 4
  reg [7:0] sum4;
  reg c4;
  wire c4_wire;
  wire [1:0] sum4_wire;
  
  adder_rom_2bit add4(c4_wire, sum4_wire, a3[7:6], b3[7:6], c3);
  
  always@(posedge Clk)
    begin
      c4 <= c4_wire;
      sum4 <= {sum4_wire, sum3};
    end
  
  assign Cout = c4;
  assign Sum = sum4;
endmodule