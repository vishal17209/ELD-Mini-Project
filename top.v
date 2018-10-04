`timescale 1ns / 1ps

module top(clk,next, rst, cathode,anode, char_polynomial);
    input clk,next,rst;
    input [3:0] char_polynomial;
    output [7:0] cathode;
    output [3:0] anode;
    
    wire [7:0] seq_out;
    wire [3:0] one,ten,hundred,thousand;
    wire ssd_clk,deb_clk,deb_rst,deb_nxt;
    
    freq_divide #(17) E(clk,ssd_clk);
    freq_divide #(19) F(clk,deb_clk);
    
    deb_pulse G(deb_clk,rst,deb_rst);
    deb_pulse H(deb_clk,next,deb_nxt);
    
    example_8_bit #(.N(4),.INITIAL(5)) I(deb_nxt,deb_rst,seq_out, char_polynomial);
    
    bcd_bin_8_bit A({4'b0,seq_out},thousand,hundred,ten,one);
    seven_seg_onboard B(one,ten,hundred,thousand,cathode,anode,ssd_clk);
    
    
endmodule
