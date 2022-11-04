`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2022 04:37:07 PM
// Design Name: 
// Module Name: Synthesizer
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


module Synthesizer(
    input clk,
    output speaker,
    output reg [2:0] note
    );
    wire longClk;
    reg [19:0] inCount;
    reg addsub;
    
    
    initial begin
        note = 3'b0;
        addsub = 1;
    end
    
    LongClkDivider LCD(.clkin(clk),.rst(0),.clkout(longClk));
    
    always @(posedge longClk)begin
        case(note)
            3'b000: inCount <= 20'b101110101010000101; //C4
            3'b001: inCount <= 20'b101001100100011001; //D4
            3'b010: inCount <= 20'b100101000010000101; //E4
            3'b011: inCount <= 20'b100010111101000100; //F4
            3'b100: inCount <= 20'b11111001000111110; //G4
            3'b101: inCount <= 20'b11011101111100100; //A4
            3'b110: inCount <= 20'b11000101101110110; //B4
            3'b111: inCount <= 20'b10111010101000100; //C5
        endcase
        if(note == 3'b111) begin
            addsub = 0; //Start Counting Down
        end
        else if(note == 3'b0) begin
            addsub = 1; //Start Counting Up
        end
        
        if(addsub) begin
            note <= note+1;
        end
        else begin
            note <= note-1;    
        end
    end
    
    ANoteClkDivider ANCD1(.clk(clk),.inCount(inCount),.speaker(speaker));
endmodule
