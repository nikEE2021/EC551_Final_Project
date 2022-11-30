`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 10:09:48 PM
// Design Name: 
// Module Name: O4_ClkDiv
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


module O4_ClkDiv(
    input [3:0] note,
    input clk_in,
    input reset,
    output reg clk_out
    );
    
    reg [9:0] cmax;
    reg [9:0] count;
    
    always @ (note) begin
        case (note)
            28: cmax <= 444;
            default: cmax <= 0;
        endcase
    end
    
    always @ (posedge clk_in or posedge reset) begin
        if (reset)
            clk_out <= 0;
            count <= 0;
        end else begin
            if (count == cmax) begin
                clk_out <= ~clk_out;
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end
    
endmodule
