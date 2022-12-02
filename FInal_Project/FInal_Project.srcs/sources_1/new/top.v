`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Thomas Kappenman
// 
// Create Date: 03/03/2015 09:06:31 PM
// Design Name: 
// Module Name: top
// Project Name: Nexys4DDR Keyboard Demo
// Target Devices: Nexys4DDR
// Tool Versions: 
// Description: This project takes keyboard input from the PS2 port,
//  and outputs the keyboard scan code to the 7 segment display on the board.
//  The scan code is shifted left 2 characters each time a new code is
//  read.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input CLK100MHZ,
    input PS2_CLK,
    input PS2_DATA,
    input SW,
    output [6:0]SEG,
    output [7:0]AN,
    output DP,
    output AUD_PWM
    );
    
    reg CLK50MHZ=0;    
    wire [31:0]keycode;
    wire clk;
    reg C4_en, D4_en, E4_en, F4_en,
        G4_en, A4_en, B4_en, C5_en;
    reg [7:0] C4_out, D4_out, E4_out, F4_out,
        G4_out, A4_out, B4_out, C5_out;
    wire [7:0] out;
    
    always @(posedge(CLK100MHZ))begin
        CLK50MHZ<=~CLK50MHZ;
    end
    
    PS2Receiver keyboard (
        .clk(CLK50MHZ),
        .kclk(PS2_CLK),
        .kdata(PS2_DATA),
        .keycodeout(keycode[31:0])
    );
    
    seg7decimal sevenSeg (
        .x(keycode[31:0]),
        .clk(CLK100MHZ),
        .seg(SEG[6:0]),
        .an(AN[7:0]),
        .dp(DP) 
    );
    
    always @(posedge clk) begin
        if(keycode[15:8] != 8'hF0) begin
            case(keycode[7:0])
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
    
    Sine_TaylorSeries #(.MAX_COUNT()) C4 (
        .clk (clk),
        .reset (C4_en),
        .out (C4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT()) D4 (
        .clk (clk),
        .reset (D4_en),
        .out (D4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT()) E4 (
        .clk (clk),
        .reset (E4_en),
        .out (E4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT()) F4 (
        .clk (clk),
        .reset (F4_en),
        .out (F4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT()) G4 (
        .clk (clk),
        .reset (G4_en),
        .out (G4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT(444)) A4 (
        .clk (clk),
        .reset (A4_en),
        .out (A4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT()) B4 (
        .clk (clk),
        .reset (B4_en),
        .out (B4_out)
    );
    
    Sine_TaylorSeries #(.MAX_COUNT()) C5 (
        .clk (clk),
        .reset (C5_en),
        .out (C5_out)
    );
    
    assign out = C4_out + D4_out + E4_out + F4_out +
        G4_out + A4_out + B4_out + C5_out;
    
    Duty_Cycler #(.ZOOM(8), .COUNT(256)) DC (
        .dc (out),
        .clk (clk),
        .reset (SW),
        .sig_out (AUD_PWM)
    );
    
//    Sine_Gen sin (
//        .clk (clk),
//        .reset (SW),
//        .sig_out (AUD_PWM)
//    );
    
//    O4_ClkDiv CD (
//        .note (keycode[7:0]),
//        .clk_in (CLK100MHZ),
//        .reset (SW),
//        .clk_out (clk)
//    );
    
endmodule
