`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2022 06:43:47 PM
// Design Name: 
// Module Name: Duty_Cycler_tb
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


module Duty_Cycler_tb;
    
    reg [3:0] dc;
    reg clk, reset;
    wire sig_out;
    
    Duty_Cycler DuCy (
        .dc (dc),
        .clk (clk),
        .reset (reset),
        .sig_out (sig_out)
    );
    
    initial begin
        clk = 0;
        reset = 1;
        dc = 7;
        #10 reset = 0;
        #160 dc = 11;
    end
    
    always begin
        #5 clk = ~clk;
    end
    
endmodule
