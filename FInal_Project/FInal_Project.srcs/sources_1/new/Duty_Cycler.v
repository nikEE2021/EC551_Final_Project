`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2022 06:31:51 PM
// Design Name: 
// Module Name: Duty_Cycler
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


module Duty_Cycler
    #(parameter ZOOM = 4, COUNT = 15)
    (
    input [ZOOM-1:0] DC,
    input clk,
    input reset,
    output reg out
    );
    
    reg [ZOOM-1:0] count;
    
    always @ (posedge clk) begin
        if (reset) begin
            count <= 0;
            out <= 1;
        end else begin
            if (count == COUNT) begin
                count <= 0;
                out <= 1;
            end else begin
                if (count == DC)
                    out <= 0;
                count <= count + 1;
            end
        end
    end
    
endmodule
