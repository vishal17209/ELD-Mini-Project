/*`timescale 1ns / 1ps

//Convert the binary number to BCD
module bcd_n_bit(number,thousands,hundreds,tens,ones);
    parameter N = 8;
    input [N-1:0] number;
    output reg [3:0] thousands,hundreds,tens,ones;
    
    reg [N+15:0] shift;
    integer i;
    
    always@(number)
    begin
        shift[N+11:N] =0;
        shift[N-1:0] = number; 
        for (i=0;i<N;i=i+1)
        begin
        	//Add 3 to the numbers if >= 5
            if (shift[N+3:N]>=5)
                shift[N+3:N] <= shift[N+3:N] + 3;
            if (shift[N+7:N+4]>=5)
                shift[N+7:N+4] <= shift[N+7:N+4] +3;
            if (shift[N+11:N+8]>=5)
                shift[N+11:N+8] <= shift[N+11:N+8]+3;
            if (shift[N+15:N+12]>=5)
                shift[N+15:N+12] <= shift[N+15:N+12]+3;
            shift = shift<<1;
            //Left shift the number by 1
        end
        thousands = shift[N+15:N+12];
        hundreds = shift[N+11:N+8];
        tens = shift[N+7:N+4];
        ones = shift[N+3:N];
        
    end
endmodule*/


`timescale 1ns / 1ps

module bcd_n_bit #(N = 1) (
  input [N-1:0] binary,
  output reg [3:0] hundred,
  output reg [3:0] tens,
  output reg [3:0] ones,
  output reg [3:0] thousands
);

//In this the BCD is generated my taking the MSB from the binary representation
//And then left shifting all the vectors to eventually convert it to 
//3 3-bit numbers

integer i;
always @(*)
begin
  hundred = 4'd0;
  tens = 4'd0;
  ones = 4'd0;
  thousands = 4'd0;

  for(i=0;i<N;i=i+1)
    begin
      if(hundred >= 5)
        hundred = hundred + 3;
      if(tens >= 5)
        tens = tens + 3;
      if(ones >= 5)
        ones = ones + 3;
      thousands = thousands << 1;
      thousands[0] = hundred[3];
      hundred = hundred << 1;
      hundred[0] = tens[3];
      tens = tens << 1;
      tens[0] = ones[3];
      ones = ones << 1;
      ones[0] = binary[N-i-1];
    end
end

endmodule