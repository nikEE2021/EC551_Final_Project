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
    
    Sine_TaylorSeries #(.MAX_COUNT(10)) STS (
        .clk (clk),
        .reset (reset),
        .out (out)
    );
    
    initial begin
        clk = 0;
        reset = 1;
        #15 reset = 0;
    end
    
    always
        #1 clk = ~clk;
    
endmodule
