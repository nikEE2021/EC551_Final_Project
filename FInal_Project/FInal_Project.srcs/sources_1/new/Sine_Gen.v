`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2022 04:30:35 PM
// Design Name: 
// Module Name: Sine_Gen
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


module Sine_Gen
    #(parameter ZOOM = 4, COUNT = 16, SIN_LEN = 16)
    (
    input clk,
    input reset,
    output sig_out
    );
    
    reg [ZOOM-1:0] sine [SIN_LEN-1:0];
    
    initial begin
        sine[0] <= 7;
        sine[1] <= 10;
        sine[2] <= 13;
        sine[3] <= 14;
        sine[4] <= 15;
        sine[5] <= 14;
        sine[6] <= 13;
        sine[7] <= 10;
        sine[8] <= 7;
        sine[9] <= 5;
        sine[10] <= 2;
        sine[11] <= 1;
        sine[12] <= 0;
        sine[13] <= 1;
        sine[14] <= 2;
        sine[15] <= 5;
    end
    
    reg [ZOOM-1:0] dc, sine_count;
    wire clk_div;
    
    Clock_Divider #(.DIV(COUNT), .WIDTH(ZOOM)) CD (
        .clk_in (clk),
        .reset (reset),
        .clk_out (clk_div)
    );
    
    always @ (posedge clk_div) begin
        if (reset) begin
            sine_count <= 0;
            dc <= (COUNT-1);
        end else begin
            dc <= sine[sine_count];
            if (sine_count == (SIN_LEN-1))
                sine_count <= 0;
            else
                sine_count <= sine_count + 1;
        end
    end
    
    Duty_Cycler #(.ZOOM(ZOOM), .COUNT(COUNT)) DC (
        .dc (dc),
        .clk (clk),
        .reset (reset),
        .sig_out (sig_out)
    );
    
endmodule
