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
    
    reg [3:0] DC;
    reg clk, reset;
    wire out;
    
    Duty_Cycler DuCy (
        .DC (DC),
        .clk (clk),
        .reset (reset),
        .out (out)
    );
    
    initial begin
        clk = 0;
        reset = 1;
        DC = 8;
        #10 reset = 0;
        #160 DC = 11;
    end
    
    always begin
        #5 clk = ~clk;
    end
    
endmodule
