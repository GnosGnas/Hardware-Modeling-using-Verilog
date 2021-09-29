module half_adder_test;

  reg A, B;
  wire S, C;

  parameter STDIN = 32'h8000_0000;
  integer testid;
  integer ret;

  half_adder hs (S, C, A, B);
  
  initial begin
      ret = $fscanf(STDIN, "%d", testid);
      case(testid)
	  0: begin #10 A=0; B=0; end
	  1: begin #10 A=0; B=1; end
	  2: begin #10 A=1; B=0; end
	  3: begin #10 A=1; B=1; end
       default: begin
	    $display("Bad testcase id %d", testid);
	    $finish();
	  end
      endcase
      #5;
	 if ( (testid == 0 && {S,C} == 2'b00) || 
	(testid == 1 && {S,C} == 2'b10) ||
	(testid == 2 && {S,C} == 2'b10) || 	
	(testid == 3 && {S,C} == 2'b01))
	  pass();
	else
	  fail();
  end
  task fail; begin
    $display("Fail: (A=%b, B=%d) != (S=%b, C=%b)", A, B, S, C);
    $finish();
    end
  endtask
  task pass; begin
    $display("Pass: (A=%b, B=%d) = (S=%b, C=%b)", A, B, S, C);
    $finish();
    end
  endtask
endmodule