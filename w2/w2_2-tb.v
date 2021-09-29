module full_adder_2bit_test;
  reg [1:0] A, B;
  reg Cin;
  wire [1:0] Sum;
  wire Carry;

  parameter STDIN = 32'h8000_0000;
  integer testid;
  integer ret;

  full_adder_2bit FA2 (Sum, Carry, A, B, Cin);
  
  initial begin
      ret = $fscanf(STDIN, "%d", testid);
      case(testid)
    0: begin #10 A=0; B=3; Cin=0; end
    1: begin #10 A=3; B=0; Cin=1; end
    2: begin #10 A=3; B=3; Cin=1; end
    3: begin #10 A=3; B=2; Cin=1; end
    4: begin #10 A=0; B=1; Cin=0; end
    5: begin #10 A=1; B=0; Cin=1; end
    6: begin #10 A=2; B=2; Cin=1; end
    7: begin #10 A=0; B=0; Cin=0; end
       default: begin
      $display("Bad testcase id %d", testid);
      $finish();
    end
      endcase
      #5;
   if ( (testid == 0 && {Carry,Sum} == 3'b011) || 
  (testid == 1 && {Carry,Sum} == 3'b100) ||
  (testid == 2 && {Carry,Sum} == 3'b111) ||   
  (testid == 3 && {Carry,Sum} == 3'b110) ||   
  (testid == 4 && {Carry,Sum} == 3'b001) ||   
  (testid == 5 && {Carry,Sum} == 3'b010) ||   
  (testid == 6 && {Carry,Sum} == 3'b101) ||   
  (testid == 7 && {Carry,Sum} == 3'b000)) 
    pass();
  else
    fail();
  end
  task fail; begin
    $display("Fail: (A=%b, B=%b, Cin=%b) != (Carry=%b, Sum=%b)", A, B, Cin, Carry, Sum);
    $finish();
    end
  endtask
  task pass; begin
    $display("Pass: (A=%b, B=%b, Cin=%b) = (Carry=%b, Sum=%b)", A, B, Cin, Carry, Sum);
    $finish();
    end
  endtask
endmodule