module timercontroller(x,b,clk);
  input b,clk;
  output x;
  
  reg [1:0] PS=0;
  
  always@(posedge clk)
    begin
      if(b)
        PS <= PS+1;
    end
  
  assign x = (PS>0);
endmodule