`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2022 02:40:07 PM
// Design Name: 
// Module Name: O4_ClkDiv_tb
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


module O4_ClkDiv_tb;
    
    reg clk_in, reset;
    reg [7:0] note;
    wire clk_out;
    
    O4_ClkDiv CD (
        .note (note),
        .clk_in (clk_in),
        .reset (reset),
        .clk_out (clk_out)
    );
    
    initial begin
        clk_in = 0;
        reset = 1;
        note = 0;
        #15 reset = 0;
        #10 note = 28;
    end
    
    always
        #1 clk_in = ~clk_in;
    
endmodule
