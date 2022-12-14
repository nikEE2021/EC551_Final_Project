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
    output reg [3:0] out
    );
    
    // constants in Taylor Series equation
    localparam [34:0] CN0 = 35'h30989B320, CN1 = 35'h5000742C0, CN2 = 35'h2782D61C0, CN3 = 35'h94ACE180,
        CD = 35'hF765FED0;
    // Taylor Series output is [0, RANGE]
    localparam RANGE = 5;
    
    
    wire clk_div;
    reg [13:0] count;
    reg neg;
    
    wire [29:0] c3;
    wire [49:0] c5;
    wire [69:0] c7;
    
    wire [19:0] m2;
    wire [39:0] m4;
    wire [59:0] m6;
    
    wire [101:0] denom;
    wire [102:0] denom2;
    
    
    // exponents of count
    assign c3 = count * count * count;
    assign c5 = count * count * count * count * count;
    assign c7 = count * count * count * count * count * count * count;
    
    // exponents of MAX_COUNT
    assign m2 = MAX_COUNT * MAX_COUNT;
    assign m4 = MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT;
    assign m6 = MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT;
    
    // denominator of Taylor Series equation
    assign denom = CD * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT * MAX_COUNT;
    assign denom2 = denom << 1;
    
    // divide clock so Taylor Series output can determine duty cycle
    Clock_Divider #(.DIV(16), .WIDTH(4)) ClkDiv (
        .clk_in (clk),
        .reset (reset),
        .clk_out (clk_div)
    );
    
    // compute Taylor Series every long clock cycle
    always @ (posedge clk_div or posedge reset) begin
        if (reset) begin
            count <= 0;
            out <= 0;
            neg <= 0;
        end else begin
            if (count == MAX_COUNT) begin
                count <= 0;
                out <= RANGE >> 1;
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
