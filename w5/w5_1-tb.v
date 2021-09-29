module buttonpressevent_test;
    reg y, clk, prev_state, prev_e;
  wire e;
  reg [7:0] state [1:0];
    
    buttonpressevent DUT (e, y, clk);

    parameter STDIN = 32'h8000_0000;
    integer testid;
    integer ret;

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    {state[0], state[1]} = "AB";
        ret = $fscanf(STDIN, "%d", testid);
      case(testid)
          0: begin
                      #2 y = 1; #4 prev_state = DUT.PS; #2 y = 1; #2 prev_e = e;  
               end
          1: begin
                      #2 y = 1; #4 prev_state = DUT.PS; #2 y = 0; #2 prev_e = e;
               end
          2: begin
                      #2 y = 1; #10 y = 0; #4 prev_state = DUT.PS; #2 y = 0; #2 prev_e = e;
               end
          3: begin
                      #2 y = 1; #10 y = 0; #4 prev_state = DUT.PS; #2 y = 1; #2 prev_e = e;
               end
            4: begin
            #2 y = 1; #4 prev_state = DUT.PS; #2 y = 1; #2 prev_e = e;  
               end
          5: begin
                      #2 y = 1; #4 prev_state = DUT.PS; #2 y = 0; #2 prev_e = e;
               end
          6: begin
                      #2 y = 1; #10 y = 0; #4 prev_state = DUT.PS; #2 y = 0; #2 prev_e = e;
               end
          7: begin
                      #2 y = 1; #10 y = 0; #4 prev_state = DUT.PS; #2 y = 1; #2 prev_e = e;
               end
            default: begin
           $display("Bad testcase id %d", testid);
           $finish();
         end
      endcase   
    #7
    if ( (testid == 0 && prev_e == 0) || (testid == 1 && prev_e == 1) ||
       (testid == 2 && prev_e == 0) || (testid == 3 && prev_e == 1) ||
       (testid == 4 && prev_e == 0) || (testid == 5 && prev_e == 1) ||
       (testid == 6 && prev_e == 0) || (testid == 7 && prev_e == 1) ) 
      pass();
    else
      fail();
  end

  task fail;  begin
        $display("(PS = %s, y = %b) => (e = %b, NS = %s)?", state[prev_state], y, prev_e, state[DUT.PS]);
        $finish();
      end
  endtask

  task pass;  begin
        $display("(PS = %s, y = %b) => (e = %b, NS = %s)", state[prev_state], y, prev_e, state[DUT.PS]);
        $finish();
      end
  endtask 
endmodule