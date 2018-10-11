//`timescale 1ns / 1ps

//module output_mask (clock, char_poly, seq_in, N, mask_in, seq_out);
//	input clock;
//	input [3:0] N;
//	input [12:0] seq_in;
//	input [4:0] mask_in;
//	input [12:0] char_poly;
//	output [12:0] seq_out;

//	integer i;
//	integer j = mask_in;
//	always @(*) begin 
//		for (i = 0; i < 13 && j > 0; i++, j--) begin
//			if(i < N-1)
//				seq[i] <= seq[i+1];
//			else if(i == N-1)
//				seq[N-1] <= ^(seq & char_poly);			
//			else
//				seq[i] <= 0;
//		end
//	end
//endmodule