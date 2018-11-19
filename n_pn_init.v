`timescale 1ns / 1ps

/*
    Module to generate the PN sequence from the initial value entered from the user
*/
module n_pn_init(next,reset,seq,N, char_poly, init);
    input [7:0] init;       //initial value of the sequence
    input next,reset;       //next value and reset signal
    input [3:0] N;          //size of the current characterstic polynomial
    input [12:0] char_poly; //charcterstic polynomial
    output reg [12:0] seq = 12'd0;  //generated sequence
    integer i;
    always@(posedge next or posedge reset)
    begin
        if (reset)
            seq <= init;        //reseting the sequence to the init value. The sequence should be reset to change the initial value of the sequence.
        else
        begin
            for (i =0;i<13;i= i+1)  //iterated over the sequence's current value
            begin
               if (i<N-1)           //if iterator is less than N-1 left shift the sequence
               begin    
                    seq[i] <= seq[i+1];   
               end
               else if (i == N-1)       //for i equal to N-1 calculate the bitwise AND with char_poly to get the bits which are 1 and then take their XOR
                    seq[N-1] <= ^(seq & char_poly);
               else
                    seq[i] <= 0;
            end
        end
    end
    
endmodule