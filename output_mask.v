`timescale 1ns / 1ps

module output_mask(
	input clock,
	input [12:0] seq_out,
	input [5:0] mask,
	output reg masked_out
    );

    
	wire [12:0] ext_mask = {7'b0000000, mask};
	always @(posedge clock) begin
		masked_out = ^(seq_out & ext_mask);
	end
endmodule
