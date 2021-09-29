module buttonpressevent(e, y, clk);
  input y, clk;
  output e;
  
  reg PS=0;
  
  always@(posedge clk)
    begin
      if(!PS & y)
        PS <= 0;
      else if (!PS & !y)
        PS <= 1;
      else if (PS & !y)
        PS <= 1;
      else
        PS <= 0;
    end
  
  assign e = ~(PS^y);
endmodule