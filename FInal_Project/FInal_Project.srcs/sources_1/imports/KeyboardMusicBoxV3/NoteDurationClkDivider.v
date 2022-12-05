`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2022 03:09:20 PM
// Design Name: 
// Module Name: NoteDurationClkDivider
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


//To get bpm: Bmp -> hz, hz -> mhz, 100/mhz, final/2 

module NoteDurationClkDivider(
    input clk,
    input [2:0] duration,
    output reg playSound,
    output reg [2:0] inCount, counter
    );

    //Div val = 227272, 100 MHZ/227272 = 440 Hz
    //flip speaker ever 113636 for 50% duty cycle
    reg [24:0] clkCounter;
    //reg [2:0] inCount, counter;
    
    initial begin
        playSound = 0;
        clkCounter = 0;
        counter = 0;
    end
    
    always @(duration) begin
        case(duration)
            2'b000: inCount = 3'b001;
            2'b001: inCount = 3'b011;
            2'b010: inCount = 3'b101;
            2'b011: inCount = 3'b111;
            default: inCount = 3'b001;
        endcase
    end
    //25'b1110010001101100110010111 100 bpm
    always @(posedge clk)begin
         if(clkCounter == 25'b1110010001101100110010111) begin //100 bpm
            if(counter == 3'b0) begin
                playSound = 1;
                counter = counter+1;
            end
            else if(counter == inCount) begin
                playSound = 0;
                counter <= 0;
            end 
            else begin
                counter = counter+1;
            end
            clkCounter <= 0;
         end 
         else begin
            clkCounter <= clkCounter+1;
         end
    end
endmodule