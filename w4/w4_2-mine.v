module bcdencoder (out, in, enable);
input [9:0] in;
output reg [3:0] out;
input enable;
integer i;

always@(*)
  begin
    for(i=0; i < 10; i = i+1)
      begin
        if(in[i] & enable)
          out = i;
      end
  end


endmodule