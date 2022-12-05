`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2022 05:19:25 PM
// Design Name: 
// Module Name: LongClkDivider
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


module LongClkDivider(
    input clkin,
    input rst,
    output reg clkout
    );
    
    reg [27:0] counter;
    
    always @(posedge clkin or posedge rst)begin
        if(rst) begin
            counter = 0;
            clkout = 0;
        end
        else if(counter == 28'b1000111100001101000110000000)begin
            clkout = ~clkout;
            counter = 0;
        end 
        else begin
            counter = counter+1;
        end
    end
endmodule
