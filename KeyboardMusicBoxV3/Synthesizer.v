`timescale 1ns / 1ps
//If keyboard F0 is in 3rd Pos, one note is playing
//if Keyboard F0 is in 4th Pos, play cord

module Synthesizer(
    input clk,
    input PS2Clk,
    input PS2Data,
    input musicBox,
    input song1, song2, song3, song4, stopSong,
    output speaker,
    output playSound,
    //output [2:0] Count, counter,
    output [6:0] seg,
    output[7:0] an,
    output dp,
	output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b,
    output vga_hsync,
    output vga_vsync
    );
	wire [10:0] vga_h_counter;
    wire [10:0] vga_v_counter;
	wire vga_blank;
	
	vga vga_display(.clk(clk),
                    .rst(rst),
                    .key_stroke(KeyboardOut[7:0]),
                    .music_box_mode(musicBox),
                    .vga_h_ctr(vga_h_counter),
                    .vga_v_ctr(vga_v_counter),
                    .vga_r(vga_r),
                    .vga_g(vga_g),
                    .vga_b(vga_b)
                    );
    
    vga_controller_640_60 vga_ctrl(
        .HS(vga_hsync),
        .VS(vga_vsync),
        .hcounter(vga_h_counter),
        .vcounter(vga_v_counter),
        .pixel_clk(clk),
        .blank(vga_blank)
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
         
	        8'h15: keyboardNote <= 20'b01011101001011101111; //C3
                8'h1D: keyboardNote <= 20'b01010011000010101000; //D3
                8'h24: keyboardNote <= 20'b01001001111110110110; //E3
                8'h2D: keyboardNote <= 20'b01000101110000010010; //F3
                8'h2C: keyboardNote <= 20'b00111110010001111110; //G3
                8'h35: keyboardNote <= 20'b00110111011111001000; //A3
                8'h3C: keyboardNote <= 20'b00110001011010111101; //B3
                8'h43: keyboardNote <= 20'b101110101010000101; //C4

                8'h1C: keyboardNote <= 20'b101110101010000101; //C4
                8'h1B: keyboardNote <= 20'b101001100100011001; //D4
                8'h23: keyboardNote <= 20'b100101000010000101; //E4
                8'h2B: keyboardNote <= 20'b100010111101000100; //F4
                8'h34: keyboardNote <= 20'b11111001000111110; //G4
                8'h33: keyboardNote <= 20'b11011101111100100; //A4
                8'h3B: keyboardNote <= 20'b11000101101110110; //B4
                8'h42: keyboardNote <= 20'b10111010101000100; //C5
                
                8'h1A: keyboardNote <= 20'b10111010101000100; //C5
                8'h22: keyboardNote <= 20'b10100110010111010; //D5
                8'h21: keyboardNote <= 20'b10010011111101101; //E5
                8'h2A: keyboardNote <= 20'b10001011111010001; //F5
                8'h32: keyboardNote <= 20'b1111100100011111; //G5
                8'h31: keyboardNote <= 20'b1101110111110010; //A5
                8'h3A: keyboardNote <= 20'b1100010110101111; //B5
                8'h41: keyboardNote <= 20'b1011101010001011; //C6
                default: keyboardNote <= 20'b0;
            endcase
        end
        else begin
            keyboardNote <= 20'b0;
        end       
    end
    
    always @(song1 or song2 or song3 or song4 or stopSong) begin
        if(song1 || song2 || song3 || song4 || stopSong) begin
            start = 1;
        end
        else begin
            start = 0;
        end 
    end
    
    MusicBoxMemory mbm(.song1(song1),.song2(song2),.song3(song3),.song4(song4),.stopSong(stopSong),.playSound(playSound),.note(musicBoxNote),.duration(duration),.start(start));

    assign inCount = (musicBox)?musicBoxNote:keyboardNote;
    
    assign playSound = (musicBox)?playDuration:1;
    
    ANoteClkDivider ANCD1(.clk(clk),.inCount((playSound)?inCount:0),.speaker(speaker)); //Uncomment me for Note Duration
    
    NoteDurationClkDivider NDCD(.clk(clk),.duration(duration),.playSound(playDuration),.inCount(Count),.counter(counter)); //Controls Note BPM and Duration
endmodule
