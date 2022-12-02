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
    input PS2Clk,
    input PS2Data,
    output speaker
    //output playSound,
    //output reg [2:0] note
    );
    wire longClk;//, playSound;
    reg [19:0] inCount;
    reg addsub;
    wire [31:0] KeyboardOut;
    wire clk_int;
    
    
    KeyboardClkDivider kcd(.clkin(clk),.rst(rst),.clkout(kclk));
    
    PS2Receiver keyboard(.clk(kclk),.kclk(PS2Clk),.kdata(PS2Data),.keycodeout(KeyboardOut));
    
    initial begin
        //note = 3'b0;
        addsub = 1;
        inCount = 0;
    end
////////////////////// KeyboardInput Loop ////////////////////////

    always @(posedge clk) begin
        if(KeyboardOut[15:8] != 8'hF0) begin
            case(KeyboardOut[7:0])
                8'h1C: inCount <= 11200; //C4
                8'h1B: inCount <= 9975; //D4
                8'h23: inCount <= 8900; //E4
                8'h2B: inCount <= 8400; //F4
                8'h34: inCount <= 7450; //G4
                8'h33: inCount <= 6650; //A4
                8'h3B: inCount <= 5925; //B4
                8'h42: inCount <= 5600; //C5
                default: inCount <= 20'b0;
            endcase
        end
        else begin
            inCount <= 20'b0;
        end       
    end

///////////////////// Loop Through Notes In Order ////////////////////////

//    LongClkDivider LCD(.clkin(clk),.rst(0),.clkout(longClk));
    
//    always @(posedge longClk)begin
//        case(note)
//            3'b000: inCount <= 191109; //C4
//            3'b001: inCount <= 170265; //D4
//            3'b010: inCount <= 151685; //E4
//            3'b011: inCount <= 143172; //F4
//            3'b100: inCount <= 127550; //G4
//            3'b101: inCount <= 113636; //A4
//            3'b110: inCount <= 101238; //B4
//            3'b111: inCount <= 95556; //C5
//        endcase
//        if(note == 3'b111) begin
//            addsub = 0; //Start Counting Down
//        end
//        else if(note == 3'b0) begin
//            addsub = 1; //Start Counting Up
//        end
        
//        if(addsub) begin
//            note <= note+1;
//        end
//        else begin
//            note <= note-1;    
//        end
//    end
    
    Sine_Gen sin (
        .clk (clk),
        .reset (),
        .sig_out (clk_int)
    );
    
    
    ANoteClkDivider ANCD1(.clk(clk_int),.inCount(inCount),.speaker(speaker)); //Uncomment me for Keyboard Loop
    //ANoteClkDivider ANCD1(.clk(clk),.inCount((playSound)?20'b101110101010000101:0),.speaker(speaker)); //Uncomment me for Note Duration
    
    //NoteDurationClkDivider NDCD(.clk(clk),.duration(2'b0),.playSound(playSound)); //Controls Note BPM and Duration
endmodule
