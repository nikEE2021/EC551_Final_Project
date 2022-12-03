`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2022 02:18:25 AM
// Design Name: 
// Module Name: Sine_TaylorSeries_tb
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


module Sine_TaylorSeries_tb;
    
    reg clk, reset;
    wire [7:0] out;
    wire sig_out, clk_div;
    
    Clock_Divider #(.DIV(16), .WIDTH(4)) ClkDiv (
        .clk_in (clk),
        .reset (reset),
        .clk_out (clk_div)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT(16)) STS (
        .clk (clk),
        .reset (reset),
        .out (out)
    );
    
    Duty_Cycler #(.ZOOM(4), .COUNT(16)) DC (
        .dc (out[7:4]),
        .clk (clk),
        .reset (reset),
        .sig_out (sig_out)
    );
    
    initial begin
        clk = 0;
        reset = 1;
        #15 reset = 0;
    end
    
    always
        #1 clk = ~clk;
    
endmodule
