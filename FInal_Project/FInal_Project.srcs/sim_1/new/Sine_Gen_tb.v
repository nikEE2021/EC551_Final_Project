`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2022 05:54:25 PM
// Design Name: 
// Module Name: Sine_Gen_tb
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


module Sine_Gen_tb;
    
    reg clk, reset;
    wire sig_out;
    
    Sine_Gen SG (
        .clk (clk),
        .reset (reset),
        .sig_out (sig_out)
    );
    
    initial begin
        clk = 0;
        reset = 1;
        #170 reset = 0;
    end
    
    always begin
        #1 clk = ~clk;
    end
    
endmodule
