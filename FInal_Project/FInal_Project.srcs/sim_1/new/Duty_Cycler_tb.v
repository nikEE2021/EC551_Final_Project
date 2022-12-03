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
    
    reg [7:0] dc;
    reg clk, reset;
    wire sig_out;
    
    Duty_Cycler #(.ZOOM(8), .COUNT(256)) DuCy (
        .dc (dc),
        .clk (clk),
        .reset (reset),
        .sig_out (sig_out)
    );
    
    initial begin
        clk = 0;
        reset = 1;
        dc = 127;
        #10 reset = 0;
        #260 dc = 63;
    end
    
    always begin
        #1 clk = ~clk;
    end
    
endmodule
