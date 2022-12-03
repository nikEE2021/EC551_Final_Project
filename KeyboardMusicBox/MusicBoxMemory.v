`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2022 10:11:39 AM
// Design Name: 
// Module Name: MusicBoxMemory
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


module MusicBoxMemory(
    input song1, song2, song3,/* song4,*/
    input playSound,
    output reg [19:0] note,
    output reg [1:0] duration,
    input start,
    output reg [4:0] memLoc,
    output reg [3:0] notecase
    );
    
    //reg [4:0] memLoc;
    //reg [3:0] notecase;
    reg [6:0] starMem [31:0];
    
    initial begin
        memLoc = 5'b0;
        starMem[0] = 7'b0; //0 never changer, acts as a wait instruction until a button press sets memLoc to 1
        starMem[1] = 7'b0;
        starMem[2] = 7'b0;
        starMem[3] = 7'b0;
        starMem[4] = 7'b0;
        starMem[5] = 7'b0;
        starMem[6] = 7'b0;
        starMem[7] = 7'b0;
        starMem[8] = 7'b0;
        starMem[9] = 7'b0;
        starMem[10] = 7'b0;
        starMem[11] = 7'b0;
        starMem[12] = 7'b0;
        starMem[13] = 7'b0;
        starMem[14] = 7'b0;
        starMem[15] = 7'b0;
        starMem[16] = 7'b0;
        starMem[17] = 7'b0;
        starMem[18] = 7'b0;
        starMem[19] = 7'b0;
        starMem[20] = 7'b0;
        starMem[21] = 7'b0;
        starMem[22] = 7'b0;
        starMem[23] = 7'b0;
        starMem[24] = 7'b0;
        starMem[25] = 7'b0;
        starMem[26] = 7'b0;
        starMem[27] = 7'b0;
        starMem[28] = 7'b0;
        starMem[29] = 7'b0;
        starMem[30] = 7'b0;
        starMem[31] = 7'b0;
    end
    
    always @(song1, song2, song3/* song4*/) begin
        if(song1) begin 
            starMem[0] = 7'b0;
            starMem[1] = 7'b1_0000_00;
            starMem[2] = 7'b1_0000_00;
            starMem[3] = 7'b1_0100_00;
            starMem[4] = 7'b1_0100_00;
            starMem[5] = 7'b1_0101_00;
            starMem[6] = 7'b1_0101_00;
            starMem[7] = 7'b1_0100_01;
            starMem[8] = 7'b1_0011_00;
            starMem[9] = 7'b1_0011_00;
            starMem[10] = 7'b1_0010_00;
            starMem[11] = 7'b1_0010_00;
            starMem[12] = 7'b1_0001_00;
            starMem[13] = 7'b1_0001_00;
            starMem[14] = 7'b1_0000_01;
            starMem[15] = 7'b0;
            starMem[16] = 7'b0;
            starMem[17] = 7'b0;
            starMem[18] = 7'b0;
            starMem[19] = 7'b0;
            starMem[20] = 7'b0;
            starMem[21] = 7'b0;
            starMem[22] = 7'b0;
            starMem[23] = 7'b0;
            starMem[24] = 7'b0;
            starMem[25] = 7'b0;
            starMem[26] = 7'b0;
            starMem[27] = 7'b0;
            starMem[28] = 7'b0;
            starMem[29] = 7'b0;
            starMem[30] = 7'b0;
            starMem[31] = 7'b0;
            //memLoc = 5'b00001;
        end
        else if(song2)begin
            starMem[0] = 7'b0;
            starMem[1] = 7'b1_0010_00;
            starMem[2] = 7'b1_0010_00;
            starMem[3] = 7'b1_0011_00;
            starMem[4] = 7'b1_0100_00;
            starMem[5] = 7'b1_0100_00;
            starMem[6] = 7'b1_0011_00;
            starMem[7] = 7'b1_0010_00;
            starMem[8] = 7'b1_0001_00;
            starMem[9] = 7'b1_0000_00;
            starMem[10] = 7'b1_0000_00;
            starMem[11] = 7'b1_0001_00;
            starMem[12] = 7'b1_0010_00;
            starMem[13] = 7'b1_0010_00;
            starMem[14] = 7'b1_0001_00;
            starMem[15] = 7'b1_0001_01;
            starMem[16] = 7'b0;
            starMem[17] = 7'b0;
            starMem[18] = 7'b0;
            starMem[19] = 7'b0;
            starMem[20] = 7'b0;
            starMem[21] = 7'b0;
            starMem[22] = 7'b0;
            starMem[23] = 7'b0;
            starMem[24] = 7'b0;
            starMem[25] = 7'b0;
            starMem[26] = 7'b0;
            starMem[27] = 7'b0;
            starMem[28] = 7'b0;
            starMem[29] = 7'b0;
            starMem[30] = 7'b0;
            starMem[31] = 7'b0;
        end
//        else if(song3)begin
//            starMem[0] = 7'b0;
//            starMem[1] = 7'b1_0000_00;
//            starMem[2] = 7'b1_0001_00;
//            starMem[3] = 7'b1_0010_00;
//            starMem[4] = 7'b1_0000_00;
//            starMem[5] = 7'b1_0000_00;
//            starMem[6] = 7'b1_0001_00;
//            starMem[7] = 7'b1_0010_00;
//            starMem[8] = 7'b1_0000_00;
//            starMem[9] = 7'b1_0010_00;
//            starMem[10] = 7'b1_0011_00;
//            starMem[11] = 7'b1_0100_01;
//            starMem[12] = 7'b0;
//            starMem[13] = 7'b0;
//            starMem[14] = 7'b0;
//            starMem[15] = 7'b0;
//            starMem[16] = 7'b0;
//            starMem[17] = 7'b0;
//            starMem[18] = 7'b0;
//            starMem[19] = 7'b0;
//            starMem[20] = 7'b0;
//            starMem[21] = 7'b0;
//            starMem[22] = 7'b0;
//            starMem[23] = 7'b0;
//            starMem[24] = 7'b0;
//            starMem[25] = 7'b0;
//            starMem[26] = 7'b0;
//            starMem[27] = 7'b0;
//            starMem[28] = 7'b0;
//            starMem[29] = 7'b0;
//            starMem[30] = 7'b0;
//            starMem[31] = 7'b0;
//        end
    end
    
    always @(notecase) begin
        case (notecase) 
            4'b0000: note = 20'b101110101010000101; //C4
            4'b0001: note = 20'b101001100100011001; //D4
            4'b0010: note = 20'b100101000010000101; //E4
            4'b0011: note = 20'b100010111101000100; //F4
            4'b0100: note = 20'b11111001000111110; //G4
            4'b0101: note = 20'b11011101111100100; //A4
            4'b0110: note = 20'b11000101101110110; //B4
            4'b0111: note = 20'b10111010101000100; //C5
            default: note = 20'b0; //Empty Note
        endcase
    end
    
    always @(posedge playSound or posedge start) begin
        if(start) begin
            memLoc = 5'b00001;
        end
        else begin
            if(starMem[memLoc][6]) begin //only play sound if instr starts with 1
                notecase <= starMem[memLoc][5:2];
                duration <= starMem[memLoc][1:0];
                memLoc <= memLoc+1;
            end
            else begin
                notecase <= 4'b1000;
                duration <= 2'b0;
                memLoc <= 5'b0;
            end
        end
    end
endmodule
