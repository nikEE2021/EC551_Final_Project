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
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output [7:0]AN,
    output DP,
    output AUD_PWM
    );
    
    reg CLK50MHZ=0;    
    wire [31:0]keycode;
    wire [6:0]SEG;
    wire clk;
    reg C4_en, D4_en, E4_en, F4_en,
        G4_en, A4_en, B4_en, C5_en;
    wire [3:0] C4_out, D4_out, E4_out, F4_out,
        G4_out, A4_out, B4_out, C5_out;
    wire [3:0] out;
    
    always @(posedge(CLK100MHZ))begin
        CLK50MHZ<=~CLK50MHZ;
    end
    
    assign clk = CLK100MHZ;
    assign {CG, CF, CE, CD, CC, CB, CA} = SEG;
    
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
        .reset (SW),
        .sig_out (AUD_PWM)
    );
    
endmodule
