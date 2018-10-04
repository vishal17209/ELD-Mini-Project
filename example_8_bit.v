`timescale 1ns / 1ps



module example_8_bit(next,reset,seq,char_poly);
    parameter N = 8;
    parameter INITIAL = 1;
    input next,reset;
    input [N-1:0] char_poly;
    output reg [N-1:0] seq = INITIAL;
    
    always@(posedge next or posedge reset)
    begin
        if (reset)
            seq <= INITIAL;
        else
        begin
            //seq[N-1] <= seq[0]^seq[3];
            seq[N-1] <= ^(seq & char_poly);
            seq[N-2:0] <= seq[N-1:1];
        end
    end
    
endmodule
