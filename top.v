`timescale 1ns / 1ps

module top(clk,next, rst, cathode,anode, num, init);
    input [7:0] init;
    input clk,next,rst;
    input [3:0] num;
    output [7:0] cathode;
    output [3:0] anode;
    
    wire [12:0] seq_out;
    wire [3:0] one,ten,hundred,thousand;
    wire ssd_clk,deb_clk,deb_rst,deb_nxt;
    wire [15:0] char_poly;
    
    freq_divide #(17) E(clk,ssd_clk);
    freq_divide #(19) F(clk,deb_clk);
    
    deb_pulse G(deb_clk,rst,deb_rst);
    deb_pulse H(deb_clk,next,deb_nxt);
    
    //example_8_bit #(.N(4),.INITIAL(5)) I(deb_nxt,deb_rst,seq_out, char_polynomial);
    
    blk_mem_gen_0 C(clk,num,char_poly);

//    output_mask O(clk, char_poly, init, num, mask_in, seq_out);
    n_bit_pn D(deb_nxt, deb_rst, seq_out, num, char_poly[12:0], init);
    
    //bcd_bin_8_bit A({4'b0,seq_out},thousand,hundred,ten,one);
    bcd_n_bit #(13) A(seq_out,hundred,ten,one,thousand);
    seven_seg_onboard B(one,ten,hundred,thousand,cathode,anode,ssd_clk);
    
    
endmodule
