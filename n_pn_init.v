`timescale 1ns / 1ps

module n_pn_init(next,reset,seq,N, char_poly, init);
    input [7:0] init;
    input next,reset;
    input [3:0] N;
    input [12:0] char_poly;
    output reg [12:0] seq = 12'd0;
    integer i;
    always@(posedge next or posedge reset)
    begin
        if (reset)
            seq <= init;
        else
        begin
            for (i =0;i<13;i= i+1)
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
        end
    end
    
endmodule