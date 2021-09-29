module adder_rom_2bit_test;
  reg [1:0] A, B;
  reg C;
  wire [1:0] Sum;
  wire Cout;
    
  adder_rom_2bit dut (Cout, Sum, A, B, C);
  
  parameter STDIN = 32'h8000_0000;
        integer testid;
        integer ret;
  
  
  initial begin
      ret = $fscanf(STDIN, "%d", testid);
      case(testid)
          0: begin
                       A = 1; B = 2; C = 0;
                   end
          1: begin
                       A = 2; B = 2; C = 1; 
                   end
          2: begin
                       A = 0; B = 0; C = 0; 
                   end
          3: begin
                       A = 3; B = 3; C = 1; 
                   end
          4: begin
                       A = 0; B = 0; C = 1;  
                   end
          5: begin
                       A = 1; B = 1; C = 1;
                   end
          6: begin
                       A = 2; B = 0; C = 1;  
                   end
          7: begin
                       A = 0; B = 3; C = 0;  
                   end
                default: begin
           $display("Bad testcase id %d", testid);
           $finish();
       end
      endcase
    #5
        if ((testid == 0 && Sum == 3 && Cout == 0) || (testid == 1 && Sum == 1 && Cout == 1) ||
        (testid == 2 && Sum == 0 && Cout == 0) || (testid == 3 && Sum == 3 && Cout == 1) || 
        (testid == 4 && Sum == 1 && Cout == 0) || (testid == 5 && Sum == 3 && Cout == 0) ||
        (testid == 6 && Sum == 3 && Cout == 0) || (testid == 7 && Sum == 3 && Cout == 0))
      pass();
    else
      fail();
  end


  task fail;  begin
        $display("Fail: (A = %d, B = %d, C = %d) => (Cout = %b, Sum = %b)?", A, B, C, Cout, Sum);
        $finish();
      end
  endtask

  task pass;  begin
        $display("Pass: (A = %d, B = %d, C = %d) => (Cout = %b, Sum = %b)", A, B, C, Cout, Sum);
        $finish();
      end
  endtask
  
endmodule