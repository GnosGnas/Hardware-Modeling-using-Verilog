module comparator_test;
    reg [2:0] A, B;
    wire C;
  
  
    comparator DUT (C, A[2], A[1], A[0], B[2], B[1], B[0]);

    parameter STDIN = 32'h8000_0000;
    integer testid;
    integer ret;

    initial begin
            ret = $fscanf(STDIN, "%d", testid);
      case(testid)
          0: begin
                       A = 0; B = 1; 
               end
          1: begin
                       A = 4; B = 3; 
               end
          2: begin
                       A = 5; B = 5; 
               end
          3: begin
                       A = 7; B = 3; 
               end
            4: begin
           A = 2; B = 2; 
               end
          5: begin
                       A = 6; B = 7; 
               end
          6: begin
                       A = 3; B = 1; 
               end
          7: begin
                       A = 1; B = 0; 
               end
            default: begin
           $display("Bad testcase id %d", testid);
           $finish();
         end
      endcase
    #2 
    if ( (testid == 0 && C == 1'b0) || (testid == 1 && C == 1'b1) ||
       (testid == 2 && C == 1'b0) || (testid == 3 && C == 1'b1) ||
       (testid == 4 && C == 1'b0) || (testid == 5 && C == 1'b0) ||
       (testid == 6 && C == 1'b1) || (testid == 7 && C == 1'b1) ) 
      pass();
    else
      fail();
  end


  task fail;  begin
        $display("Fail: (A = %b, B = %b) => C != %b", A, B, C);
        $finish();
      end
  endtask

  task pass;  begin
        $display("Pass: (A = %b, B = %b) => C == %b", A, B, C);
        $finish();
      end
  endtask
endmodule