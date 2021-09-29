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