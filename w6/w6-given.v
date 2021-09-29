module PIPO (Out, In, Clear, Load, Clk);
    input [7:0] In;
    input Load, Clear, Clk; 

    output reg [7:0] Out;

    always @ (posedge Clk) begin
        if (Clear == 1) Out = 8'b0;
        else if (Load == 1) Out = In;
    end
endmodule

module CNTR(Out, Clear, Inc, Clk);
    input Clear, Inc, Clk; 
    output reg [7:0] Out;

    always @ (negedge Clk) begin
        if (Clear == 1) Out = 8'b0;
        else if (Inc == 1) Out = Out + 1;
    end
endmodule

module adder(Out, In1, In2);
    input [7:0] In1, In2; 
    output [7:0] Out;

    assign Out = In1 + In2;
endmodule  

module comparator(Out, In1, In2);
    input [7:0] In1, In2; 
    output Out;

    assign Out = In1 < In2 ? 0 : 1;
endmodule  

module sum_series_datapath (CltN, LoadN, LoadR, Clear, IncC, Data_in, Clk);
    input LoadN, LoadR, Clear, IncC, Clk;
    input [7:0] Data_in;
    output CltN;
    wire [7:0] Nw, Rw, Cw, Aw;    

    PIPO N (Nw, Data_in, Clear, LoadN, Clk);
	PIPO R (Rw, Aw, Clear, LoadR, Clk);    
    CNTR  C (Cw, Clear, IncC, Clk);
    adder ADD (Aw, Cw, Rw);
    comparator CMP (CltN, Cw, Nw);
endmodule

module sum_series_ctrlpath (LoadN, LoadR, Clear, IncC, Stop, Clk, CltN, Start);
    input Clk, CltN, Start;
    output reg LoadN, LoadR, Clear, IncC, Stop;

    reg [1:0] state;
    parameter S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;

    always @(posedge Clk) begin
        case (state)
            S0: if (Start) state <= S1;
            S1: state <= S2;
            S2: if (CltN == 0) state <= S2; else state <= S3;
            S3: state <= S3;
            default: state <= S0;
        endcase
    end
    always @(state) begin
        case (state)
            S0: begin #1 LoadN = 0; LoadR = 0; Clear = 1; IncC = 0; Stop = 0; end 
            S1: begin #1 LoadN = 1; Clear = 0; end
            S2: begin #1 LoadR = 1; LoadN = 0; IncC = 1; end
            S3: begin #1 LoadN = 0; LoadR = 0; IncC = 0; Stop = 1; end
            default: begin #1 LoadN = 0; LoadR = 0; Clear = 1; IncC = 0; Stop = 0; end 
        endcase
    end
endmodule