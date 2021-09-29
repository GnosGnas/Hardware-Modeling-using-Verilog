
module FullAdder(input a,b,cin, output cout,s);
      assign cout = a&b|b&cin|cin&a;
      assign s = a^b^cin;
endmodule

module CRA(a,b,sum,cout);
      parameter N = 2;

      input [N-1:0] a,b;
      output cout;
      output [N-1:0] sum;

      wire [N-1:0] c;

      assign cout = c[N-1];

      FullAdder FA0(a[0],b[0],1'b0,c[0],sum[0]);

      genvar p;
      for(p = 1;p<N;p=p+1)
            begin:fa
            FullAdder FA(a[p],b[p],c[p-1],c[p],sum[p]);
            end
endmodule

module full_adder_2bit (Sum, Carry, A, B, Cin);
  input [1:0] A, B;
  input Cin;
  output [1:0] Sum;
  output Carry;
  reg [1:0] Sum;
  reg Carry;
  
  wire [1:0] temp_sum;
  wire temp_carry;
  wire [1:0] temp_sum1;
  wire temp_carry1;
  
  CRA r1(A, B, temp_sum, temp_carry);
         
  CRA r2(temp_sum, {1'b0,Cin}, temp_sum1, temp_carry1);
  
  always @(*)
    begin
      Sum <= temp_sum1;
      Carry <= temp_carry1 | temp_carry;
    end
endmodule