module dff(q, d, clk, rst);
  input d, clk, rst;
  output reg q;

  always @(posedge clk) begin
    if (rst==1'b1) q <= 1'b0;
    else q <= d;
  end
endmodule

module reg8bit(out, in, clk, ld, asr, lsl, clr);
  output [7:0] out;
  input [7:0] in;
  input clk;
  input ld;
  input asr;
  input lsl;
  input clr;
  
  reg [7:0] ff_inp;
  wire [7:0] ff_out;

  assign out = ff_out;
    
  genvar p;
  for(p=0;p<8;p=p+1)
    begin:rg
      dff dff_rg(ff_out[p], ff_inp[p], clk, clr);
    end

  
  always@(*)
    begin
      if(ld)
        begin
          ff_inp = in;
        end
      else
        begin
          if(asr)
          begin
            ff_inp = {ff_out[7],ff_out[7:1]};
          end
          else if (lsl)
          begin
            ff_inp = {ff_out[6:0],1'b0};
          end
        end
    end
endmodule
