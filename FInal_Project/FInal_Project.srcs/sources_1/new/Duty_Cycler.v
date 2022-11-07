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
    #(parameter ZOOM = 4, COUNT = 16)
    (
    input [ZOOM-1:0] dc,
    input clk,
    input reset,
    output reg sig_out
    );
    
    reg [ZOOM-1:0] count;
    
    always @ (posedge clk) begin
        if (reset) begin
            count <= 0;
            sig_out <= 1;
        end else begin
            if (count == (COUNT-1)) begin
                count <= 0;
                sig_out <= 1;
            end else begin
                if (count == dc)
                    sig_out <= 0;
                count <= count + 1;
            end
        end
    end
    
endmodule
