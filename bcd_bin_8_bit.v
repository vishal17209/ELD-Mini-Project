`timescale 1ns / 1ps

//Convert the binary number to BCD
module bcd_bin_8_bit(number,thousands,hundreds,tens,ones);
    input [7:0] number;
    output reg [3:0] thousands,hundreds,tens,ones;
    
    reg [19:0] shift;
    integer i;
    
    always@(number)
    begin
        shift[19:8] =0;
        shift[7:0] = number; 
        for (i=0;i<8;i=i+1)
        begin
        	//Add 3 to the numbers if >= 5
            if (shift[11:8]>=5)
                shift[11:8] = shift[11:8] + 3;
            if (shift[15:12]>=5)
                shift[15:12] = shift[15:12] +3;
            if (shift[19:16]>=5)
                shift[19:16] = shift[19:16]+3;
            shift = shift<<1;
            //Left shift the number by 1
        end
        hundreds = shift[19:16];
        tens = shift[15:12];
        ones = shift[11:8];
        thousands = 4'b0000;
    end
endmodule