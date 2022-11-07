`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2022 01:42:13 PM
// Design Name: 
// Module Name: Clock_Divider_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Clock_Divider_tb;
    reg clk_in, reset;
    wire clk_out;
    
    Clock_Divider #(.DIV(16), .WIDTH(4)) Clk_Div (
        .clk_in (clk_in),
        .reset (reset),
        .clk_out (clk_out)
    );
    
    initial begin
        clk_in = 0;
        reset = 1;
        #10 reset = 0;
    end
    
    always begin
        #5 clk_in = ~clk_in;
    end
    
endmodule
