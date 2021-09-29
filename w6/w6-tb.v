module sum_series_test;
    reg [7:0] Data_in, N_prev;
    reg Clk, Start;
    wire Stop;
    
    parameter STDIN = 32'h8000_0000;
    integer testid;
    integer ret;

    sum_series_datapath DP (CltN, LoadN, LoadR, Clear, IncC, Data_in, Clk);
    sum_series_ctrlpath CP (LoadN, LoadR, Clear, IncC, Stop, Clk, CltN, Start);

    initial Clk = 1'b0;
    always #5 Clk = ~Clk;
      
    initial begin
      ret = $fscanf(STDIN, "%d", testid);
      case(testid)
          0: begin
                       #2 Start = 1; #20 Data_in = 4; 
                   end
          1: begin
                       #2 Start = 1; #20 Data_in = 9; 
                   end
          2: begin
                       #2 Start = 1; #20 Data_in = 5; 
                   end
          3: begin
                       #2 Start = 1; #20 Data_in = 12; 
                   end
          4: begin
                       #2 Start = 1; #20 Data_in = 3;
                   end
          5: begin
                       #2 Start = 1; #20 Data_in = 6;
                   end
          6: begin
                       #2 Start = 1; #20 Data_in = 7; 
                   end
          7: begin
                       #2 Start = 1; #20 Data_in = 8; 
                   end
            default: begin
           $display("Bad testcase id %d", testid);
           $finish();
       end
      endcase
    #200;
        if ((testid == 0 && DP.Rw == 10 && Stop == 1) || (testid == 1 && DP.Rw == 45 && Stop == 1) ||
        (testid == 2 && DP.Rw == 15 && Stop == 1) || (testid == 3 && DP.Rw == 78 && Stop == 1) || 
        (testid == 4 && DP.Rw == 6  && Stop == 1) || (testid == 5 && DP.Rw == 21 && Stop == 1) ||
        (testid == 6 && DP.Rw == 28 && Stop == 1) || (testid == 7 && DP.Rw == 36 && Stop == 1))
      pass();
    else
      fail();
  end
  
  task fail;  begin
        $display("Fail: (Sum of first N=%d terms) => (R = %d)?", DP.Nw, DP.Rw);
        $finish();
      end
  endtask

  task pass;  begin
        $display("Pass: (Sum of first N=%d terms) => (R = %d)", DP.Nw, DP.Rw);
        $finish();
      end
  endtask
endmodule