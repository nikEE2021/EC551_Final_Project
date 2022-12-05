`timescale 1ns / 1ps
//If keyboard F0 is in 3rd Pos, one note is playing
//if Keyboard F0 is in 4th Pos, play cord

module Synthesizer(
    input clk,
    input SW,
    input PS2Clk,
    input PS2Data,
    input musicBox,
    input song1, song2, song3, song4, stopSong,
    output AUD_PWM,
    output playSound,
    //output [2:0] Count, counter,
    output [6:0] seg,
    output[7:0] an,
    output dp
//	output [3:0] vga_r,
//    output [3:0] vga_g,
//    output [3:0] vga_b,
//    output vga_hsync,
//    output vga_vsync
    );
	wire [10:0] vga_h_counter;
    wire [10:0] vga_v_counter;
	wire vga_blank;
	
//	vga vga_display(.clk(clk),
//        .rst(),
//        .key_stroke(KeyboardOut[7:0]),
//        .music_box_mode(musicBox),
//        .vga_h_ctr(vga_h_counter),
//        .vga_v_ctr(vga_v_counter),
//        .vga_r(vga_r),
//        .vga_g(vga_g),
//        .vga_b(vga_b)
//    );
    
//    vga_controller_640_60 vga_ctrl(
//        .HS(vga_hsync),
//        .VS(vga_vsync),
//        .hcounter(vga_h_counter),
//        .vcounter(vga_v_counter),
//        .pixel_clk(clk),
//        .blank(vga_blank)
//    );
	
    wire longClk, kclk, playDuration;
    wire [1:0] duration;
    wire [2:0] Count, counter;
    wire [19:0] inCount, musicBoxNote;
    wire [31:0] KeyboardOut;
    wire sine_out, speaker;
    reg start;
    reg [19:0] keyboardNote;
    reg C4_en, D4_en, E4_en, F4_en,
        G4_en, A4_en, B4_en, C5_en;
    wire [3:0] C4_out, D4_out, E4_out, F4_out,
        G4_out, A4_out, B4_out, C5_out;
    wire [3:0] out;
    
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
    
    always @(posedge clk) begin
        if(KeyboardOut[15:8] != 8'hF0) begin
            case(KeyboardOut[7:0])
                8'h1C: C4_en <= 0;//C4
                8'h1B: D4_en <= 0;//D4
                8'h23: E4_en <= 0;//E4
                8'h2B: F4_en <= 0;//F4
                8'h34: G4_en <= 0;//G4
                8'h33: A4_en <= 0;//A4
                8'h3B: B4_en <= 0;//B4
                8'h42: C5_en <= 0;//C5
                default: begin
                    C4_en <= 1;
                    D4_en <= 1;
                    E4_en <= 1;
                    F4_en <= 1;
                    G4_en <= 1;
                    A4_en <= 1;
                    B4_en <= 1;
                    C5_en <= 1;
                end
            endcase
        end
    end
    
    Sine_TaylorSeries #(.MAX_COUNT(11944)) C4 (
        .clk (clk),
        .reset (C4_en),
        .out (C4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT(10642)) D4 (
        .clk (clk),
        .reset (D4_en),
        .out (D4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT(9480)) E4 (
        .clk (clk),
        .reset (E4_en),
        .out (E4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT(8948)) F4 (
        .clk (clk),
        .reset (F4_en),
        .out (F4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT(7972)) G4 (
        .clk (clk),
        .reset (G4_en),
        .out (G4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT(7102)) A4 (
        .clk (clk),
        .reset (A4_en),
        .out (A4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT(6327)) B4 (
        .clk (clk),
        .reset (B4_en),
        .out (B4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT(5972)) C5 (
        .clk (clk),
        .reset (C5_en),
        .out (C5_out)
    );
    
    assign out = C4_out + D4_out + E4_out + F4_out +
        G4_out + A4_out + B4_out + C5_out;
    
    Duty_Cycler #(.ZOOM(4), .COUNT(16)) DC (
        .dc (out),
        .clk (clk),
        .reset (),
        .sig_out (sine_out)
    );
    
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
    
    assign AUD_PWM = SW ? sine_out : speaker;
    
    NoteDurationClkDivider NDCD(.clk(clk),.duration(duration),.playSound(playDuration),.inCount(Count),.counter(counter)); //Controls Note BPM and Duration
endmodule
