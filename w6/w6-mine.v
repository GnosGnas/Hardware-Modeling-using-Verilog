module sum_series_datapath(CltN, LoadN, LoadR, Clear, IncC, Data_in, Clk);
  input LoadN, LoadR, Clear, IncC, Clk;
  input [7:0] Data_in;
  output CltN;
  wire [7:0] Nw, Cw, Rw, z,bus;
  
  pipo1 n(Nw, LoadN, Data_in, Clear, Clk);
  pipo2 r(Rw, z, LoadR,Clear, Clk);
  cntr c(Cw, Clear, IncC, Clk);
  add a(z, Rw, Cw);
  eqz comp(CltN, Nw, Cw);
endmodule

module pipo1(Nw, LoadN, Data_in, Clear, Clk);
  input [7:0] Data_in;
  input LoadN, Clear, Clk;
  output reg [7:0] Nw;
  always@(posedge Clk)
    if(Clear)
      Nw <= 7'b0;
  else if(LoadN)
    Nw <= Data_in;
endmodule


module pipo2(Rw, z, LoadR, Clear, Clk);
  input [7:0] z;
  input Clear, LoadR, Clk;
  output reg [7:0] Rw;
  always@(posedge Clk)
    if(Clear)
      Rw <= 7'b0;
  else if(LoadR)
    Rw <= z;
endmodule


module eqz(CltN, Nw, Cw);
  input [7:0] Nw, Cw;
output CltN;
  assign CltN = (Nw==Cw);
endmodule

module cntr (Cw,Clear, IncC,Clk);
input Clear, IncC,Clk;
  output reg [7:0] Cw;
  always@(negedge Clk)
    if(Clear)
Cw<=7'b0;
  else if(IncC)
Cw<=Cw+1;
endmodule

module add(z, Cw, Rw);
  input [7:0] Cw, Rw;
  output reg [7:0] z;
  always@(*)
z=Cw+Rw;
endmodule


module sum_series_ctrlpath(LoadN, LoadR, Clear, IncC, Stop, Clk, CltN, Start);
input Clk,eqz, Start,CltN;
output reg LoadN, LoadR,Clear, IncC, Stop;
  reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010,s3=3'b011;
  always@(posedge Clk)
begin
  case(state)
    s0:if(Start) state<=s1;
s1: state<=s2;
    s2:if(CltN) state<=s3;
s3:state<=s3;
default: state<=s0;
endcase
end
  
  always@(state)
begin
  case(state)
s0:begin#1LoadN=0; LoadR=0;Clear=1;IncC=0; end
s1: begin#1LoadN=1; LoadR=0;Clear=0; IncC=0; end
s2:begin#1 LoadN=0; LoadR=1;Clear=0; IncC=1; end
s3: begin#1Stop=1; LoadN=0; LoadR=0; IncC=0;end
default: begin#1 LoadN=0; LoadR=0;Clear=0; IncC=0;end
endcase
end
endmodule
