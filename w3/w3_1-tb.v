module dff_test;
    reg d, q_prev, clk, rst;
    wire out;

    parameter STDIN = 32'h8000_0000;
    integer testid;
    integer ret;
  
  initial clk = 0;
  always  #10 clk = ~clk;

    dff D1 (q, d, clk, rst);

    initial begin
    ret = $fscanf(STDIN, "%d", testid);
    //$monitor($time,  " clk = %d (q = %b, d = %b, rst = %b) => q != %b", clk, q_prev, d, rst, q);
      case(testid)
          0: begin
                       #5  q_prev = q; rst = 1'b0;  
               end
          1: begin
                       #5  q_prev = q; rst = 1'b1;             
               end
          2: begin
                       #5  rst = 1'b1;             
             #10 q_prev = q; d = 1'b1; rst = 1'b0;
               end
          3: begin
                       #5  q_prev = q; d = 1'b1; rst = 1'b0;                         
               end
            4: begin
             #5  q_prev = q; d = 1'b1; rst = 1'b1;
               end
          5: begin
                       #5  d = 1'b1; rst = 1'b0;             
             #10 q_prev = q; d = 1'b0; rst = 1'b0;
               end
          6: begin
                       #5  d = 1'b1; rst = 1'b1;             
             #10 q_prev = q; d = 1'b0; rst = 1'b0;
               end
          7: begin
                       #5  d = 1'b1; rst = 1'b1;             
             #10 q_prev = q; d = 1'b1; rst = 1'b0;
               end
            default: begin
           $display("Bad testcase id %d", testid);
           $finish();
         end
      endcase
            #20; //$finish; end
      
    if ( (testid == 0 && q === 1'bx) || (testid == 1 && q == 1'b0) ||
         (testid == 2 && q == 1'b1) || (testid == 3 && q == 1'b1) ||
         (testid == 4 && q == 1'b0) || (testid == 5 && q == 1'b0) ||
         (testid == 6 && q == 1'b0) || (testid == 7 && q == 1'b1) )
      pass();
    else
      fail();
  end


  task fail;  begin
        $display("Fail: (q = %b, d = %b, rst = %b) => q != %b", q_prev, d, rst, q);
        $finish();
      end
  endtask

  task pass;  begin
        $display("Pass: (q = %b, d = %b, rst = %b) => q == %b", q_prev, d, rst, q);
        $finish();
      end
  endtask
endmodule
