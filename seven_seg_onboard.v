`timescale 1ns / 1ps

module seven_seg_onboard(ones,tens,hundreds,thousands,cathode,anode,clk);
    input clk;
    input [3:0] ones,tens,hundreds,thousands;
    output [7:0] cathode;
    output [3:0] anode;
    reg [3:0] num;
    reg [6:0] sseg_temp;
    reg [3:0] anode_temp = 4'b1111;
    reg [1:0] choose = 2'b0;
    
    always@(num)
        begin
            case(num)
            4'd0: sseg_temp = 7'b0000001;
            4'd1: sseg_temp = 7'b1001111;
            4'd2: sseg_temp = 7'b0010010;
            4'd3: sseg_temp = 7'b0000110;
            4'd4: sseg_temp = 7'b1001100;
            4'd5: sseg_temp = 7'b0100100;
            4'd6: sseg_temp = 7'b0100000;
            4'd7: sseg_temp = 7'b0001111;
            4'd8: sseg_temp = 7'b0000000;
            4'd9: sseg_temp = 7'b0000100;
            default: sseg_temp = 7'b1111110;
            endcase
        end
    always@(posedge clk)
        begin
            if (choose == 2'd0)
                begin
                    anode_temp = 4'b1110;
                    num = ones;
                    choose = choose+1;
                end 
            else if (choose == 2'd1)
                begin
                    anode_temp  = 4'b1101;
                    num = tens;  
                    choose = choose+1;
                end
            else if (choose == 2'd2)
                begin
                    anode_temp = 4'b1011;
                    num = hundreds;
                    choose = choose+1;
                end
            else
                begin
                    anode_temp = 4'b0111;
                    num = thousands;
                    choose = choose+1;
                end
            
        end
        assign anode = anode_temp;
        assign cathode = {sseg_temp,1'b1};

endmodule
