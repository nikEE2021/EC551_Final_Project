`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2022 10:42:55 AM
// Design Name: 
// Module Name: Clock_Divider
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


module Clock_Divider
    #(parameter DIV=16, WIDTH = 4)
    (
    input clk_in,
    input reset,
    output reg clk_out
    );
    
    reg [WIDTH-1:0] count;
    
    always @ (posedge clk_in) begin
        if (reset) begin
            clk_out <= 1;
            count <= 0;
        end else begin
            if (count == (DIV-1)) begin
                clk_out <= 1;
                count <= 0;
            end else begin
                if (count == (DIV/2-1))
                    clk_out <= 0;
                count <= count + 1;
            end
        end
    end
    
endmodule
