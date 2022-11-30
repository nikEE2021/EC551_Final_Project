`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2022 02:36:44 PM
// Design Name: 
// Module Name: synth_top
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


module synth_top(
    input CLK100MHZ,
    input PS2_CLK,
    input PS2_DATA,
    input SW,
    output AUD_PWM
    );
    
    reg CLK50MHZ=0;    
    wire [31:0]keycode;
    
    always @(posedge(CLK100MHZ))begin
        CLK50MHZ<=~CLK50MHZ;
    end
    
    PS2Receiver keyboard (
        .clk(CLK50MHZ),
        .kclk(PS2_CLK),
        .kdata(PS2_DATA),
        .keycodeout(keycode[31:0])
    );
    Sine_Gen sin (
        .clk (CLK100MHZ),
        .reset (SW),
        .sig_out (AUD_PWM)
    );
    
    O4_ClkDiv CD (
        .note (note),
        .clk_in (clk_in),
        .reset (reset),
        .clk_out (clk_out)
    );
    
endmodule
