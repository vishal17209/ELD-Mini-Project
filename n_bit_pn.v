`timescale 1ns / 1ps


module n_bit_pn(next,reset,seq,N, char_poly);
    parameter INITIAL = 1;
    input next,reset;
    input [3:0] N;
    input [12:0] char_poly;
    output reg [12:0] seq = INITIAL;
    integer i;
    always@(posedge next or posedge reset)
    begin
        if (reset)
            seq <= INITIAL;
        else
        begin
            //seq[N-1] <= seq[0]^seq[3];
            
            for (i =0;i<=12;i= i+1)
            begin
               if (i<N-1)
               begin
                    seq[i] <= seq[i+1];
               end
               else if (i == N-1)
                    seq[N-1] <= ^(seq & char_poly);
               else
                    seq[i] <= 0;
            end
            //seq[N-2:0] <= seq[N-1:1];
        end
    end
    
endmodule
