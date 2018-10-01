`timescale 1ns / 1ps

//Divide the frequency by 2^N
module freq_divide(clk,out_clk);
	//General N can be used to generate different frequencies
	parameter N = 25;
	input clk;
	output out_clk;

	reg [N-1:0] counter=0;

	always @(posedge clk ) begin 
		counter = counter + 1;
	end

	assign out_clk = counter[N-1];
endmodule // freq_divide