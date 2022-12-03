`timescale 1ns / 1ps
//If keyboard F0 is in 3rd Pos, one note is playing
//if Keyboard F0 is in 4th Pos, play cord

module Synthesizer(
    input clk,
    input PS2Clk,
    input PS2Data,
    input musicBox,
    input song1, song2, song3,
    output speaker,
    output playSound,
    //output [2:0] Count, counter,
    output [6:0] seg,
    output[7:0] an,
    output dp,
    output [4:0] memLoc,
    output [3:0] notecase
    );
    wire longClk, kclk, playDuration;
    wire [1:0] duration;
    wire [2:0] Count, counter;
    wire [19:0] inCount, musicBoxNote;
    wire [31:0] KeyboardOut;
    reg start;
    reg [19:0] keyboardNote;
    
    KeyboardClkDivider kcd(.clkin(clk),.clkout(kclk));
    
    PS2Receiver keyboard(.clk(kclk),.kclk(PS2Clk),.kdata(PS2Data),.keycodeout(KeyboardOut));
    
    SevenSegDisplay(.x(KeyboardOut),.clk(clk),.seg(seg),.an(an),.dp(dp)); 
    
    initial begin
        keyboardNote = 0;
        start = 0;
    end
    
//////////////////////// KeyboardInput Loop ////////////////////////

    always @(posedge clk) begin
        if(KeyboardOut[15:8] != 8'hF0) begin
            case(KeyboardOut[7:0])
                8'h1C: keyboardNote <= 20'b101110101010000101; //C4
                8'h1B: keyboardNote <= 20'b101001100100011001; //D4
                8'h23: keyboardNote <= 20'b100101000010000101; //E4
                8'h2B: keyboardNote <= 20'b100010111101000100; //F4
                8'h34: keyboardNote <= 20'b11111001000111110; //G4
                8'h33: keyboardNote <= 20'b11011101111100100; //A4
                8'h3B: keyboardNote <= 20'b11000101101110110; //B4
                8'h42: keyboardNote <= 20'b10111010101000100; //C5
                default: keyboardNote <= 20'b0;
            endcase
        end
        else begin
            keyboardNote <= 20'b0;
        end       
    end
    
    always @(song1 or song2 or song3) begin
        if(song1 || song2 || song3) begin
            start = 1;
        end
        else begin
            start = 0;
        end 
    end
    
    MusicBoxMemory mbm(.song1(song1),.song2(song2),.song3(song3),.playSound(playSound),.note(musicBoxNote),.duration(duration),.start(start),.memLoc(memLoc),.notecase(notecase));
    
    //assign duration = (s1)?3'b000:(s2)?3'b001:(s3)?3'b010:(s4)?3'b011:3'b100;
    //assign musicBoxNote = 20'b101110101010000101;
    
    assign inCount = (musicBox)?musicBoxNote:keyboardNote;
    
    assign playSound = (musicBox)?playDuration:1;
    
    //ANoteClkDivider ANCD1(.clk(clk),.inCount(inCount),.speaker(speaker)); //Uncomment me for Keyboard Loop
    ANoteClkDivider ANCD1(.clk(clk),.inCount((playSound)?inCount:0),.speaker(speaker)); //Uncomment me for Note Duration
    
    NoteDurationClkDivider NDCD(.clk(clk),.duration(duration),.playSound(playDuration),.inCount(Count),.counter(counter)); //Controls Note BPM and Duration
endmodule