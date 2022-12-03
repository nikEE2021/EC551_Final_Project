`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2022 12:43:57 AM
// Design Name: 
// Module Name: Sine_TaylorSeries
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


module Sine_TaylorSeries
    #(parameter MAX_COUNT = 1000)
    (
    input clk,
    input reset,
    output reg [7:0] out
    );
    
    localparam [34:0] CN0 = 35'h30989B320, CN1 = 35'h5000742C0, CN2 = 35'h2782D61C0, CN3 = 35'h94ACE180,
        CD = 35'hF765FED0;
    localparam RANGE = 63;
    
    
    wire clk_256;
    reg [9:0] count;
    reg neg;
    
    wire [29:0] c3;
    wire [49:0] c5;
    wire [69:0] c7;
    
    wire [19:0] m2;
    wire [39:0] m4;
    wire [59:0] m6;
    
    wire [101:0] denom;
    wire [102:0] denom2;
    
    assign c3 = count * count * count;
    assign c5 = count * count * count * count * count;
    assign c7 = count * count * count * count * count * count * count;
    
    assign m2 = MAX_COUNT * MAX_COUNT;
    assign m4 = MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT;
    assign m6 = MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT;
    
    assign denom = CD * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT;
    assign denom2 = denom << 1;
    
    Clock_Divider #(.DIV(256), .WIDTH(8)) ClkDiv (
        .clk_in (clk),
        .reset (reset),
        .clk_out (clk_256)
    );
    
    always @ (posedge clk_256 or posedge reset) begin
        if (reset) begin
            count <= 0;
            out <= 0;
            neg <= 0;
        end else begin
            if (count == MAX_COUNT) begin
                count <= 0;
                out <= RANGE / 2;
                neg <= ~neg;
            end else begin
                count <= count + 1;
                if (~neg)
                    out <= (RANGE * ((CN0 * m6 * count + CN2 * m2 * c5) - (CN1 * m4 * c3 + CN3 * c7) + denom)) / denom2;
                else
                    out <= (RANGE * ((CN1 * m4 * c3 + CN3 * c7) - (CN0 * m6 * count + CN2 * m2 * c5) + denom)) / denom2;
            end
        end
    end
    
endmodule
