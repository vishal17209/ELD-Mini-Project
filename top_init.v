`timescale 1ns / 1ps

/*
    top module for PN sequence generator which generated the masked value 
    according to the output mask entered
*/
module top_init(clk,next, rst, cathode,anode, num, init,mask);
    input [5:0] init;           //inital value for the sequence
    input clk,next,rst;         //clock, next value and reset signal respectively
    input [3:0] num;            //selection line for the characterstic polynomial for maximum sequence length
    output [7:0] cathode;       //cathode for 7 seven segment display
    output [3:0] anode;         //anode for 7 segment display
    input [5:0] mask;           //output mask polynomial
    
    //Variables
    wire [12:0] seq_out;                    //sequence output from n_pn_init
    wire [3:0] one,ten,hundred,thousand;    //BCD outputs
    wire ssd_clk,deb_clk,deb_rst,deb_nxt;   //debounced signals and clocks
    wire [15:0] char_poly;                  //characterstic polynomial
    wire [12:0] masked_out;                 //masked output

    //frequency dividers
    freq_divide #(17) E(clk,ssd_clk);       
    freq_divide #(19) F(clk,deb_clk);
    
    //creating a pulse for reset and next
    deb_pulse G(deb_clk,rst,deb_rst);
    deb_pulse H(deb_clk,next,deb_nxt);
    
    //example_8_bit #(.N(4),.INITIAL(5)) I(deb_nxt,deb_rst,seq_out, char_polynomial);
    
    //getting the characterstic polynomial from BRAM
    blk_mem_gen_0 C(clk,1,num,char_poly);
    
    //generating a new value in the sequence
    n_pn_init D(deb_nxt, deb_rst, seq_out, num, char_poly[12:0], init);
    
    //bcd_bin_8_bit A({4'b0,seq_out},thousand,hundred,ten,one);
    //get the masked value for the enter masked output
    assign masked_out = (mask==5'b0)?seq_out:^(seq_out&mask);
    
    //convert the number to BCD and display it on the seven segment display
    bcd_n_bit #(13) A(masked_out,hundred,ten,one,thousand);
    seven_seg_onboard B(one,ten,hundred,thousand,cathode,anode,ssd_clk);
    
endmodule