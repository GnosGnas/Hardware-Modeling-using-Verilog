module timercontroller_test;
    reg b, clk, prev_state;
  wire x;
  reg [23:0] state [3:0];
  integer cycles; 
    timercontroller DUT (x, b, clk);

    parameter STDIN = 32'h8000_0000;
    integer testid;
    integer ret;

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    {state[0], state[1], state[2], state[3]} = "Offon1on2on3";
        ret = $fscanf(STDIN, "%d", testid);
      case(testid)
          0: begin
                      #7 b = 0; #4 prev_state = DUT.PS; #10;
               end
          1: begin
                      #7 b = 0; #4 prev_state = DUT.PS; #10 b = 1; #6;
               end
          2: begin
                      #7 b = 0; #4 prev_state = DUT.PS; b = 1;  #20; 
               end
          3: begin
                      #7 b = 0; #4 prev_state = DUT.PS; b = 1; #30; 
               end
            4: begin
            #7 b = 0; #4 prev_state = DUT.PS; b = 1; #40; 
               end
          5: begin
                      #7 b = 0; #4 prev_state = DUT.PS; b = 1; #50; 
               end
          6: begin
                      #7 b = 0; #4 prev_state = DUT.PS; b = 1; #60; 
               end
          7: begin
                      #7 b = 0; #4 prev_state = DUT.PS; #60; 
               end
            default: begin
           $display("Bad testcase id %d", testid);
           $finish();
         end
      endcase   
    cycles = $time / 10 - 1;
    if ( (testid == 0 && x == 0) || (testid == 1 && x == 1) ||
       (testid == 2 && x == 1) || (testid == 3 && x == 1) ||
       (testid == 4 && x == 0) || (testid == 5 && x == 1) ||
       (testid == 6 && x == 1) || (testid == 7 && x == 0) ) 
      pass();
    else
      fail();
  end

  task fail;  begin
        $display("(PS = %s, b = %b, clock cycles = %2d) => (x = %b, NS = %s)?", state[prev_state], b, cycles, x, state[DUT.PS]);
        $finish();
      end
  endtask

  task pass;  begin
        $display("(PS = %s, b = %b, clock cycles = %2d) => (x = %b, NS = %s)", state[prev_state], b, cycles, x, state[DUT.PS]);
        $finish();
      end
  endtask 
endmodule