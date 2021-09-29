module pipe_adder_8bit_test;
  reg [7:0] X, X_prev, Y, Y_prev;
  reg Cin, Cin_prev, Clk;
  wire [7:0] Sum;
  wire Cout;
  
  
  pipe_adder_8bit dut (Cout, Sum, X, Y, Cin, Clk);
  
  parameter STDIN = 32'h8000_0000;
        integer testid;
        integer ret;
  
  initial Clk = 1'b0;
        always #5 Clk = ~Clk;
  
  initial begin
      ret = $fscanf(STDIN, "%d", testid);
      case(testid)
          0: begin
                      #2 X = 6; Y = 7; Cin = 0; X_prev = X; Y_prev = Y; Cin_prev = Cin; #55;
                   end
          1: begin
                      #2 X = 6; Y = 7; Cin = 0; 
            #10 X = 12; Y = 24; Cin = 1; 
            #10 X_prev = X; Y_prev = Y; Cin_prev = Cin; X = 2; Y = 4; Cin = 0;#35;
                   end
          2: begin
                      #2 X = 36; Y = 40; Cin = 0; X_prev = X; Y_prev = Y; Cin_prev = Cin; #55;
                   end
          3: begin
                      #12 X = 6; Y = 7; Cin = 0; 
            #10 X = 128; Y = 128; Cin = 0; X_prev = X; Y_prev = Y; Cin_prev = Cin;#55;
                   end
          4: begin
                      #2 X = 0; Y = 0; Cin = 1; X_prev = X; Y_prev = Y; Cin_prev = Cin;#55;
                   end
          5: begin
                      #2 X = 0; Y = 0; Cin = 1; 
            #10 X = 128; Y = 160; Cin = 0; 
            #10 X_prev = X; Y_prev = Y; Cin_prev = Cin; X = 8; Y = 0; Cin = 0; #35;
                   end
          6: begin
                      #2 X = 64; Y = 32; Cin = 0; X_prev = X; Y_prev = Y; Cin_prev = Cin; #55;
                   end
          7: begin
                      #2 X = 64; Y = 32; Cin = 0; 
            #10 X = 192; Y = 128; Cin = 1; X_prev = X; Y_prev = Y; Cin_prev = Cin; #55;
                   end
                default: begin
           $display("Bad testcase id %d", testid);
           $finish();
       end
      endcase
        if ((testid == 0 && Sum == 13 && Cout == 0) || (testid == 1 && Sum == 37 && Cout == 0) ||
        (testid == 2 && Sum == 76 && Cout == 0) || (testid == 3 && Sum ==  0 && Cout == 1) || 
        (testid == 4 && Sum ==  1 && Cout == 0) || (testid == 5 && Sum == 32 && Cout == 1) ||
        (testid == 6 && Sum == 96 && Cout == 0) || (testid == 7 && Sum == 65 && Cout == 1))
      pass();
    else
      fail();
  end
  task fail;  begin
        $display("Fail: (X = %d, Y = %d, Cin = %d) => (Cout = %d, Sum = %d)?", X_prev, Y_prev, Cin_prev, Cout, Sum);
        $finish();
      end
  endtask

  task pass;  begin
        $display("Pass: (X = %d, Y = %d, Cin = %d) => (Cout = %d, Sum = %d)", X_prev, Y_prev, Cin_prev, Cout, Sum);
        $finish();
      end
  endtask
endmodule