`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2022 03:38:03 PM
// Design Name: 
// Module Name: KeyboardClkDivider
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


module KeyboardClkDivider(
    input clkin,
    output reg clkout
    );
    
    initial begin
        clkout = 0;
    end
    
    always @(posedge clkin) begin
        clkout = ~clkout;
    end
endmodule
