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
    input music_box_mode,
    output speaker,
//    output playSound,
//    output reg [2:0] note,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b,
    output vga_hsync,
    output vga_vsync
    );
    wire longClk;//, playSound;
    reg [19:0] inCount;
    reg addsub;
    wire [31:0] KeyboardOut;
    
    KeyboardClkDivider kcd(.clkin(clk),.rst(rst),.clkout(kclk));
    
    PS2Receiver keyboard(.clk(kclk),.kclk(PS2Clk),.kdata(PS2Data),.keycodeout(KeyboardOut));
    
    wire [10:0] vga_h_counter;
    wire [10:0] vga_v_counter;
//    wire vga_pixel;
    wire vga_blank;
    wire red_color;
    
//    assign vga_r = (vga_pixel) ? 4'hf : 4'h0;
//    assign vga_g = (vga_pixel) ? 4'hf : 4'h0;
//    assign vga_b = (vga_pixel) ? 4'hf : 4'h0;
        
//    vga vga_display(.clk(clk),.rst(rst),.key_stroke(KeyboardOut[7:0]),.vga_h_ctr(vga_h_counter),.vga_v_ctr(vga_v_counter),.vga_pixel_on(vga_pixel),.red(red_color));
    
    vga vga_display(.clk(clk),
                    .rst(rst),
                    .key_stroke(KeyboardOut[7:0]),
//                    .music_box_mode(music_box_mode),
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
    
    initial begin
//        note = 3'b0;
        addsub = 1;
        inCount = 0;
    end
//////////////////////// KeyboardInput Loop ////////////////////////

    always @(posedge clk) begin
        if(KeyboardOut[15:8] != 8'hF0) begin
            case(KeyboardOut[7:0])
                8'h1C: inCount <= 20'b101110101010000101; //C4
                8'h1B: inCount <= 20'b101001100100011001; //D4
                8'h23: inCount <= 20'b100101000010000101; //E4
                8'h2B: inCount <= 20'b100010111101000100; //F4
                8'h34: inCount <= 20'b11111001000111110; //G4
                8'h33: inCount <= 20'b11011101111100100; //A4
                8'h3B: inCount <= 20'b11000101101110110; //B4
                8'h42: inCount <= 20'b10111010101000100; //C5
                default: inCount <= 20'b0;
            endcase
        end
        else begin
            inCount <= 20'b0;
        end       
    end

/////////////////////// Loop Through Notes In Order ////////////////////////

//    LongClkDivider LCD(.clkin(clk),.rst(0),.clkout(longClk));
    
//    always @(posedge longClk)begin
//        case(note)
//            3'b000: inCount <= 20'b101110101010000101; //C4
//            3'b001: inCount <= 20'b101001100100011001; //D4
//            3'b010: inCount <= 20'b100101000010000101; //E4
//            3'b011: inCount <= 20'b100010111101000100; //F4
//            3'b100: inCount <= 20'b11111001000111110; //G4
//            3'b101: inCount <= 20'b11011101111100100; //A4
//            3'b110: inCount <= 20'b11000101101110110; //B4
//            3'b111: inCount <= 20'b10111010101000100; //C5
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
    
    ANoteClkDivider ANCD1(.clk(clk),.inCount(inCount),.speaker(speaker)); //Uncomment me for Keyboard Loop
//    ANoteClkDivider ANCD1(.clk(clk),.inCount((playSound)?20'b101110101010000101:0),.speaker(speaker)); //Uncomment me for Note Duration
    
    NoteDurationClkDivider NDCD(.clk(clk),.duration(2'b0),.playSound(playSound)); //Controls Note BPM and Duration
endmodule
