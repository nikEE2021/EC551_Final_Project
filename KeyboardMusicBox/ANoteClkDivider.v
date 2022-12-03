`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2022 04:30:38 PM
// Design Name: 
// Module Name: ANoteClkDivider
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


module ANoteClkDivider(
    input clk,
    input [19:0] inCount,
    output reg speaker
    );

//Div val = 227272, 100 MHZ/227272 = 440 Hz
//flip speaker ever 113636 for 50% duty cycle
reg [19:0] counter;

initial begin
    speaker = 0;
end
//C4 = 101110101010000101
//D4 = 101001100100011001
//E4 = 100101000010000101
//F4 = 100010111101000100
//G4 = 11111001000111110
//A4 = 11011101111100100
//B4 = 11000101101110110
//C5 = 10111010101000100
//G0 = 11111001000111110111
always @(posedge clk)begin
    if(counter == inCount) begin
        speaker = ~speaker;
        counter <= 0; 
     end 
     else begin
     counter <= counter+1;
     end
end
endmodule
