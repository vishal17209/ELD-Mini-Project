`timescale 1ns / 1ps

module deb_pulse(in_clk,clr,out_clr);
    input in_clk,clr;
    output out_clr;
    
    reg d1,d2,d3;
    
    always@(posedge in_clk)
    begin
        d1<=clr;
        d2 <= d1;
        d3 <= ~d2;
    end
    assign out_clr = d1&&d2&&d3;
endmodule
