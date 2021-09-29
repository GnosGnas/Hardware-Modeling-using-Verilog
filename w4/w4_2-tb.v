module bcdencoder_test;
    reg [9:0] in;
    reg enable;
    wire [3:0] out;
    
    bcdencoder DUT (out, in, enable);

    parameter STDIN = 32'h8000_0000;
    integer testid;
    integer ret;

    initial 
        begin
            ret = $fscanf(STDIN, "%d", testid);
      case(testid)
          0: begin
                       enable = 0; in = 10'b1000000000; 
               end
          1: begin
                       enable = 1; in = 10'b1000000000;
               end
          2: begin
                       enable = 1; in = 10'b0000000001;
               end
          3: begin
                       enable = 1; in = 10'b0001000000;
               end
            4: begin
           enable = 1; in = 10'b0000000010;
               end
          5: begin
                       enable = 1; in = 10'b0000010000;
               end
          6: begin
                       enable = 1; in = 10'b0100000000;
               end
          7: begin
                       enable = 1; in = 10'b0000001000;
               end
            default: begin
           $display("Bad testcase id %d", testid);
           $finish();
         end
      endcase
    #2 
    if ( (testid == 0 && out === 4'bxxxx) || (testid == 1 && out == 4'b1001) ||
       (testid == 2 && out == 4'b0000) || (testid == 3 && out == 4'b0110) ||
       (testid == 4 && out == 4'b0001) || (testid == 5 && out == 4'b0100) ||
       (testid == 6 && out == 4'b1000) || (testid == 7 && out == 4'b0011) ) 
      pass();
    else
      fail();
  end

  task fail;  begin
        $display("Fail: (enable = %b, in = %b) => out != %b", enable, in, out);
        $finish();
      end
  endtask

  task pass;  begin
        $display("Pass: (enable = %b, in = %b) => out == %b", enable, in, out);
        $finish();
      end
  endtask
endmodule