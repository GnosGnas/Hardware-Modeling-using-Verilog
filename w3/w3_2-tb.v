module reg8bit_test;
    reg [7:0] in, out_prev;
  reg clk, ld, asr, lsl, clr;
    wire [7:0] out;

    parameter STDIN = 32'h8000_0000;
    integer testid;
    integer ret;
  
  initial clk = 0;
  always  #10 clk = ~clk;

    reg8bit R1 (out, in, clk, ld, asr, lsl, clr);

    initial 
        begin
            ret = $fscanf(STDIN, "%d", testid);
      case(testid)
          0: begin
                       #5  out_prev = out; {ld,asr,lsl,clr} = 4'b0001; 
                   end
          1: begin
                       #5  {ld,asr,lsl,clr} = 4'b0001;   
             #10 out_prev = out; in = 8'b10000000; {ld,asr,lsl,clr} = 4'b1000; 
               end
          2: begin
                       #5  in = 8'b10000000; {ld,asr,lsl,clr} = 4'b1000;
             #10 out_prev = out; in = 8'b00000000; {ld,asr,lsl,clr} = 4'b0100;
               end
          3: begin
                       #5  in = 8'b10000011; {ld,asr,lsl,clr} = 4'b1000;
             #10 out_prev = out; in = 8'b00000000; {ld,asr,lsl,clr} = 4'b0010;                         
               end
            4: begin
             #5  in = 8'b10000011; {ld,asr,lsl,clr} = 4'b1000;
             #10 out_prev = out; in = 8'b00000000; {ld,asr,lsl,clr} = 4'b0000;
               end
          5: begin
                       #5  {ld,asr,lsl,clr} = 4'b0001;   
             #10 out_prev = out; in = 8'b11110000; {ld,asr,lsl,clr} = 4'b1000;
               end
          6: begin
                       #5  in = 8'b00111100; {ld,asr,lsl,clr} = 4'b1000;
             #10 out_prev = out; in = 8'b11111111; {ld,asr,lsl,clr} = 4'b0100;
               end
          7: begin
                       #5  in = 8'b01111000; {ld,asr,lsl,clr} = 4'b1000;
             #10 out_prev = out; in = 8'b11111111; {ld,asr,lsl,clr} = 4'b0010;                         
               end
            default: begin
           $display("Bad testcase id %d", testid);
           $finish();
         end
      endcase
            #20;
    if ( (testid == 0 && out == 8'b00000000) || (testid == 1 && out == 8'b10000000) ||
       (testid == 2 && out == 8'b11000000) || (testid == 3 && out == 8'b00000110) ||
       (testid == 4 && out == 8'b10000011) || (testid == 5 && out == 8'b11110000) ||
       (testid == 6 && out == 8'b00011110) || (testid == 7 && out == 8'b11110000) ) 
      pass();
    else
      fail();
  end


  task fail;  begin
        $display("Fail: (out = %b, in = %b, ld = %b, asr = %b, lsl = %b, clr = %b) => out != %b", out_prev, in, ld, asr, lsl, clr, out);
        $finish();
      end
  endtask

  task pass;  begin
        $display("Pass: (out = %b, in = %b, ld = %b, asr = %b, lsl = %b, clr = %b) => out == %b", out_prev, in, ld, asr, lsl, clr, out);
        $finish();
      end
  endtask
endmodule