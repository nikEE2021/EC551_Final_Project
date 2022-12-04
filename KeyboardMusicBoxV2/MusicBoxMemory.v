//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 12/02/2022 10:11:39 AM
//// Design Name: 
//// Module Name: MusicBoxMemory
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module MusicBoxMemory(
//    input song1, song2, song3,/* song4,*/
//    input playSound,
//    output reg [19:0] note,
//    output reg [1:0] duration,
//    input start,
//    output reg [4:0] memLoc,
//    output reg [3:0] notecase
//    );
    
//    //reg [4:0] memLoc;
//    //reg [3:0] notecase;
//    reg [6:0] starMem [31:0];
    
//    initial begin
//        memLoc = 5'b0;
//        starMem[0] = 7'b0; //0 never changer, acts as a wait instruction until a button press sets memLoc to 1
//        starMem[1] = 7'b0;
//        starMem[2] = 7'b0;
//        starMem[3] = 7'b0;
//        starMem[4] = 7'b0;
//        starMem[5] = 7'b0;
//        starMem[6] = 7'b0;
//        starMem[7] = 7'b0;
//        starMem[8] = 7'b0;
//        starMem[9] = 7'b0;
//        starMem[10] = 7'b0;
//        starMem[11] = 7'b0;
//        starMem[12] = 7'b0;
//        starMem[13] = 7'b0;
//        starMem[14] = 7'b0;
//        starMem[15] = 7'b0;
//        starMem[16] = 7'b0;
//        starMem[17] = 7'b0;
//        starMem[18] = 7'b0;
//        starMem[19] = 7'b0;
//        starMem[20] = 7'b0;
//        starMem[21] = 7'b0;
//        starMem[22] = 7'b0;
//        starMem[23] = 7'b0;
//        starMem[24] = 7'b0;
//        starMem[25] = 7'b0;
//        starMem[26] = 7'b0;
//        starMem[27] = 7'b0;
//        starMem[28] = 7'b0;
//        starMem[29] = 7'b0;
//        starMem[30] = 7'b0;
//        starMem[31] = 7'b0;
//    end
    
//    always @(song1, song2, song3/* song4*/) begin
//        if(song1) begin 
//            starMem[0] = 7'b0;
//            starMem[1] = 7'b1_0000_00;
//            starMem[2] = 7'b1_0000_00;
//            starMem[3] = 7'b1_0100_00;
//            starMem[4] = 7'b1_0100_00;
//            starMem[5] = 7'b1_0101_00;
//            starMem[6] = 7'b1_0101_00;
//            starMem[7] = 7'b1_0100_01;
//            starMem[8] = 7'b1_0011_00;
//            starMem[9] = 7'b1_0011_00;
//            starMem[10] = 7'b1_0010_00;
//            starMem[11] = 7'b1_0010_00;
//            starMem[12] = 7'b1_0001_00;
//            starMem[13] = 7'b1_0001_00;
//            starMem[14] = 7'b1_0000_01;
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
//            //memLoc = 5'b00001;
//        end
//        else if(song2)begin
//            starMem[0] = 7'b0;
//            starMem[1] = 7'b1_0010_00;
//            starMem[2] = 7'b1_0010_00;
//            starMem[3] = 7'b1_0011_00;
//            starMem[4] = 7'b1_0100_00;
//            starMem[5] = 7'b1_0100_00;
//            starMem[6] = 7'b1_0011_00;
//            starMem[7] = 7'b1_0010_00;
//            starMem[8] = 7'b1_0001_00;
//            starMem[9] = 7'b1_0000_00;
//            starMem[10] = 7'b1_0000_00;
//            starMem[11] = 7'b1_0001_00;
//            starMem[12] = 7'b1_0010_00;
//            starMem[13] = 7'b1_0010_00;
//            starMem[14] = 7'b1_0001_00;
//            starMem[15] = 7'b1_0001_01;
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
//    end
    
//    always @(notecase) begin
//        case (notecase) 
//            4'b0000: note = 20'b101110101010000101; //C4
//            4'b0001: note = 20'b101001100100011001; //D4
//            4'b0010: note = 20'b100101000010000101; //E4
//            4'b0011: note = 20'b100010111101000100; //F4
//            4'b0100: note = 20'b11111001000111110; //G4
//            4'b0101: note = 20'b11011101111100100; //A4
//            4'b0110: note = 20'b11000101101110110; //B4
//            4'b0111: note = 20'b10111010101000100; //C5
//            default: note = 20'b0; //Empty Note
//        endcase
//    end
    
//    always @(posedge playSound or posedge start) begin
//        if(start) begin
//            memLoc = 5'b00001;
//        end
//        else begin
//            if(starMem[memLoc][6]) begin //only play sound if instr starts with 1
//                notecase <= starMem[memLoc][5:2];
//                duration <= starMem[memLoc][1:0];
//                memLoc <= memLoc+1;
//            end
//            else begin
//                notecase <= 4'b1000;
//                duration <= 2'b0;
//                memLoc <= 5'b0;
//            end
//        end
//    end
//endmodule


`timescale 1ns / 1ps

module MusicBoxMemory(
    input song1, song2, song3, song4,
    input playSound,
    output reg [19:0] note,
    output reg [1:0] duration,

    input start,
    output reg [5:0] memLoc,
    output reg [4:0] notecase
    );
    
    //reg [4:0] memLoc;
    //reg [3:0] notecase;

    reg [7:0] songMem [60:0]; // format: {(5'b_note)(2'b_duration)}
    
    initial begin
        memLoc = 5'b0;

        songMem[0] = 8'b0; //0 never changer, acts as a wait instruction until a button press sets memLoc to 1
        songMem[1] = 8'b0;
        songMem[2] = 8'b0;
        songMem[3] = 8'b0;
        songMem[4] = 8'b0;
        songMem[5] = 8'b0;
        songMem[6] = 8'b0;
        songMem[7] = 8'b0;
        songMem[8] = 8'b0;
        songMem[9] = 8'b0;
        songMem[10] = 8'b0;
        songMem[11] = 8'b0;
        songMem[12] = 8'b0;
        songMem[13] = 8'b0;
        songMem[14] = 8'b0;
        songMem[15] = 8'b0;
        songMem[16] = 8'b0;
        songMem[17] = 8'b0;
        songMem[18] = 8'b0;
        songMem[19] = 8'b0;
        songMem[20] = 8'b0;
        songMem[21] = 8'b0;
        songMem[22] = 8'b0;
        songMem[23] = 8'b0;
        songMem[24] = 8'b0;
        songMem[25] = 8'b0;
        songMem[26] = 8'b0;
        songMem[27] = 8'b0;
        songMem[28] = 8'b0;
        songMem[29] = 8'b0;
        songMem[30] = 8'b0;
        songMem[31] = 8'b0;
        songMem[32] = 8'b0;
        songMem[33] = 8'b0;
        songMem[34] = 8'b0;
        songMem[35] = 8'b0;
        songMem[36] = 8'b0;
        songMem[37] = 8'b0;
        songMem[38] = 8'b0;
        songMem[39] = 8'b0;
        songMem[40] = 8'b0;
        songMem[41] = 8'b0;
        songMem[42] = 8'b0;
        songMem[43] = 8'b0;
        songMem[44] = 8'b0;
        songMem[45] = 8'b0;
        songMem[46] = 8'b0;
        songMem[47] = 8'b0;
        songMem[48] = 8'b0;
        songMem[49] = 8'b0;
        songMem[50] = 8'b0;
        songMem[51] = 8'b0;
        songMem[52] = 8'b0;
        songMem[53] = 8'b0;
        songMem[54] = 8'b0;
        songMem[55] = 8'b0;
        songMem[56] = 8'b0;
        songMem[57] = 8'b0;
        songMem[58] = 8'b0;
        songMem[59] = 8'b0;
        songMem[60] = 8'b0;
        
    end
    
    always @(song1, song2, song3, song4) begin
//        if(song1) begin // STAR
//        	songMem[0] = 8'b0;

//            songMem[1] = 8'b1_0_1001_00;
//	        songMem[2] = 8'b1_0_1001_00;
//	        songMem[3] = 8'b1_0_1101_00;
//	        songMem[4] = 8'b1_0_1101_00;
//	        songMem[5] = 8'b1_0_1110_00;
//	        songMem[6] = 8'b1_0_1110_00;
//	        songMem[7] = 8'b1_0_1101_01;//
//	        songMem[8] = 8'b1_0_1100_00;
//	        songMem[9] = 8'b1_0_1100_00;
//	        songMem[10] = 8'b1_0_1011_00;
//	        songMem[11] = 8'b1_0_1011_00; 
//	        songMem[12] = 8'b1_0_1010_00;
//	        songMem[13] = 8'b1_0_1010_00;
//	        songMem[14] = 8'b1_0_1001_01;//
	        
//	        songMem[15] = 8'b1_0_1101_00;
//	        songMem[16] = 8'b1_0_1101_00;
//	        songMem[17] = 8'b1_0_1100_00;
//	        songMem[18] = 8'b1_0_1100_00;
//	        songMem[19] = 8'b1_0_1011_00;
//	        songMem[20] = 8'b1_0_1011_00;
//	        songMem[21] = 8'b1_0_1010_01;//
//	        songMem[22] = 8'b1_0_1101_00;
//	        songMem[23] = 8'b1_0_1101_00;
//	        songMem[24] = 8'b1_0_1100_00;
//	        songMem[25] = 8'b1_0_1100_00;
//	        songMem[26] = 8'b1_0_1011_00;
//	        songMem[27] = 8'b1_0_1011_00;
//	        songMem[28] = 8'b1_0_1010_01;//
	       
//	        songMem[29] = 8'b1_0_1001_00;
//	        songMem[30] = 8'b1_0_1001_00;
//	        songMem[31] = 8'b1_0_1101_00; 
//	        songMem[32] = 8'b1_0_1101_00;
//	        songMem[33] = 8'b1_0_1110_00;
//	        songMem[34] = 8'b1_0_1110_00;
//	        songMem[35] = 8'b1_0_1101_01;//
//	        songMem[36] = 8'b1_0_1100_00;
//	        songMem[37] = 8'b1_0_1100_00;
//	        songMem[38] = 8'b1_0_1011_00;
//	        songMem[39] = 8'b1_0_1011_00;
//	        songMem[40] = 8'b1_0_1010_00;
//	        songMem[41] = 8'b1_0_1010_00;
//	        songMem[42] = 8'b1_0_1001_01;//

//            //memLoc = 5'b00001;
//        end
//        else if(song2)begin // JOY
//            songMem[0] = 8'b0;
            
//	        songMem[1] = 8'b1_0_1011_00;
//	        songMem[2] = 8'b1_0_1011_00;
//	        songMem[3] = 8'b1_0_1100_00;
//	        songMem[4] = 8'b1_0_1101_00;//
//	        songMem[5] = 8'b1_0_1101_00;
//	        songMem[6] = 8'b1_0_1100_00;
//	        songMem[7] = 8'b1_0_1011_00;
//	        songMem[8] = 8'b1_0_1010_00;//
//	        songMem[9] = 8'b1_0_1001_00;
//	        songMem[10] = 8'b1_0_1001_00;
//	        songMem[11] = 8'b1_0_1010_00;
//	        songMem[12] = 8'b1_0_1011_00;//
//	        songMem[13] = 8'b1_0_1011_00;
//	        songMem[14] = 8'b1_0_1010_00;
//	        songMem[15] = 8'b1_0_1010_01;//
	        
//	        songMem[16] = 8'b1_0_1011_00;
//	        songMem[17] = 8'b1_0_1011_00;
//	        songMem[18] = 8'b1_0_1100_00;
//	        songMem[19] = 8'b1_0_1101_00;//
//	        songMem[20] = 8'b1_0_1101_00;
//	        songMem[21] = 8'b1_0_1100_00;
//	        songMem[22] = 8'b1_0_1011_00;
//	        songMem[23] = 8'b1_0_1010_00;//
//	        songMem[24] = 8'b1_0_1001_00;/////
//	        songMem[25] = 8'b1_0_1001_00;
//	        songMem[26] = 8'b1_0_1010_00;
//	        songMem[27] = 8'b1_0_1011_00;//
//	        songMem[28] = 8'b1_0_1010_00;
//	        songMem[29] = 8'b1_0_1001_00;
//	        songMem[30] = 8'b1_0_1001_01;//
	        
//	        songMem[31] = 8'b1_0_1010_00;
//	        songMem[32] = 8'b1_0_1010_00;
//	        songMem[33] = 8'b1_0_1011_00;
//	        songMem[34] = 8'b1_0_1001_00;//
//	        songMem[35] = 8'b1_0_1010_00;
//	        songMem[36] = 8'b1_0_1100_00;
//	        songMem[37] = 8'b1_0_1011_00;
//	        songMem[38] = 8'b1_0_1001_00;//
//	        songMem[39] = 8'b1_0_1010_00;
//	        songMem[40] = 8'b1_0_1100_00;
//	        songMem[41] = 8'b1_0_1011_00;
//	        songMem[42] = 8'b1_0_1010_00;//
//	        songMem[43] = 8'b1_0_1001_00;
//	        songMem[44] = 8'b1_0_1010_00;
//	        songMem[45] = 8'b1_0_1101_01;//
	        
//	        songMem[46] = 8'b1_0_1011_00;
//	        songMem[47] = 8'b1_0_1011_00;
//	        songMem[48] = 8'b1_0_1100_00;
//	        songMem[49] = 8'b1_0_1101_00;//
//	        songMem[50] = 8'b1_0_1101_00;
//	        songMem[51] = 8'b1_0_1100_00;
//	        songMem[52] = 8'b1_0_1011_00;
//	        songMem[53] = 8'b1_0_1010_00;//
//	        songMem[54] = 8'b1_0_1001_00;
//	        songMem[55] = 8'b1_0_1001_00;
//	        songMem[56] = 8'b1_0_1010_00;
//	        songMem[57] = 8'b1_0_1011_00;//
//	        songMem[58] = 8'b1_0_1010_00;
//	        songMem[59] = 8'b1_0_1001_00;
//	        songMem[60] = 8'b1_0_1001_01;//
//        end
          if(song3)begin // JAS 
		
			songMem[0] = 8'b0;

	        songMem[1] = 8'b1_0_1001_01;
	        songMem[2] = 8'b1_0_1001_00;
	        songMem[3] = 8'b1_0_1011_00;
	        songMem[4] = 8'b1_0_1101_01;
	        songMem[5] = 8'b1_0_1110_01;
	        songMem[6] = 8'b1_0_1101_11;
	        songMem[7] = 8'b1_0_1011_01;

	        songMem[8] = 8'b1_0_1001_01;
	        songMem[9] = 8'b1_0_1001_00;
	        songMem[10] = 8'b1_0_1011_00;
	        songMem[11] = 8'b1_0_1101_01;
	        songMem[12] = 8'b1_0_1110_01;
	        songMem[13] = 8'b1_0_1101_11;
	        songMem[14] = 8'b1_0_1011_01; //

	        
	        songMem[15] = 8'b1_0_1011_01;
	        songMem[16] = 8'b1_0_1101_01;
	        songMem[17] = 8'b1_0_1110_01;
	        songMem[18] = 8'b1_0_1101_01;
	        
	        songMem[19] = 8'b1_1_0000_01;
	        songMem[20] = 8'b1_0_1110_01;
	        songMem[21] = 8'b1_0_1101_10;
	        
	        songMem[22] = 8'b1_0_1001_01;
	        songMem[23] = 8'b1_0_1001_00;
	        songMem[24] = 8'b1_0_1011_00;
	        songMem[25] = 8'b1_0_1101_01;
	        songMem[26] = 8'b1_0_1110_01;
	        
	        songMem[27] = 8'b1_1_0000_01;
	        songMem[28] = 8'b1_0_1110_01;
	        songMem[29] = 8'b1_0_1101_10;
	        
	        songMem[30] = 8'b1_0_1101_01;
	        songMem[31] = 8'b1_0_1101_01;
	        songMem[32] = 8'b1_0_1110_10;
	        songMem[33] = 8'b1_0_1110_00;//
	        
	        
	        songMem[34] = 8'b1_1_0000_01;
	        songMem[35] = 8'b1_1_0000_00;
	        songMem[36] = 8'b1_0_1110_00;
	        songMem[37] = 8'b1_0_1101_10;
	        
	        songMem[38] = 8'b1_0_1101_01;
	        songMem[39] = 8'b1_0_1101_00;
	        songMem[40] = 8'b1_0_1110_00;
	        songMem[41] = 8'b1_0_1101_10;
	        songMem[42] = 8'b1_0_1101_10;
	        
	        songMem[43] = 8'b1_0_1101_01;
	        songMem[44] = 8'b1_0_1101_00;
	        songMem[45] = 8'b1_0_1110_00;
	        songMem[46] = 8'b1_0_1101_10;
	        songMem[47] = 8'b1_0_1101_10;
        end
        
        else if(song4)begin // OLD McDONALD 
		
			songMem[0] = 8'b0;

	        songMem[1] = 8'b1_1_0000_00;
	        songMem[2] = 8'b1_1_0000_00;
	        songMem[3] = 8'b1_1_0000_00;
	        songMem[4] = 8'b1_0_1101_00;
	        songMem[5] = 8'b1_0_1110_00;
	        songMem[6] = 8'b1_0_1110_00;
	        songMem[7] = 8'b1_0_1101_01;//
	         
	        songMem[8] = 8'b1_1_0010_00;
	        songMem[9] = 8'b1_1_0010_00;
	        songMem[10] = 8'b1_1_0001_00;
	        songMem[11] = 8'b1_1_0001_00;
	        songMem[12] = 8'b1_1_0000_01;//
	        /////
	        songMem[13] = 8'b1_1_0000_00;
	        songMem[14] = 8'b1_1_0000_00;
	        songMem[15] = 8'b1_1_0000_00;
	        songMem[16] = 8'b1_0_1101_00;
	        songMem[17] = 8'b1_0_1110_00;
	        songMem[18] = 8'b1_0_1110_00;
	        songMem[19] = 8'b1_0_1101_01;//
	         
	        songMem[20] = 8'b1_1_0010_00;
	        songMem[21] = 8'b1_1_0010_00;
	        songMem[22] = 8'b1_1_0001_00;
	        songMem[23] = 8'b1_1_0001_00;
	        songMem[24] = 8'b1_1_0000_01;//
	         
        end
    end
    
    always @(notecase) begin
        case (notecase) 
            5'b0_0000: note <= 20'b01011101001011101111; //C3
	        5'b0_0001: note <= 20'b01010011000010101000; //D3
	        5'b0_0010: note <= 20'b01001001111110110110; //E3
	        5'b0_0011: note <= 20'b01000101110000010010; //F3
	        5'b0_0100: note <= 20'b00111110010001111110; //G3
	        5'b0_0101: note <= 20'b00110111011111001000; //A3
	        5'b0_0110: note <= 20'b00110001011010111101; //B3
	        // 5'b0_1000: zero
	        
	        5'b0_1001: note <= 20'b101110101010000101; //C4
	        5'b0_1010: note <= 20'b101001100001010100; //D4
	        5'b0_1011: note <= 20'b00100100111111011011; //E4
	        5'b0_1100: note <= 20'b00100010111000001001; //F4
	        5'b0_1101: note <= 20'b00011111001000111111; //G4
	        5'b0_1110: note <= 20'b00011011101111100100; //A4
	        5'b0_1111: note <= 20'b00011000101101011110; //B4
	        
	        5'b1_0000: note <= 20'b10111010101110010; //C5
	        5'b1_0001: note <= 20'b10100110010111010; //D5
	        5'b1_0010: note <= 20'b10010011111101101; //E5
	        5'b1_0011: note <= 20'b10001011111010001; //F5
	        5'b1_0100: note <= 20'b1111100100011111; //G5
	        5'b1_0101: note <= 20'b1101110111110010; //A5
	        5'b1_0110: note <= 20'b1100010110101111; //B5
	        5'b1_0111: note <= 20'b1011101010001011; //C6
	        
            default: note = 20'b0; //Empty Note
        endcase
    end
    
    always @(posedge playSound or posedge start) begin
        if(start) begin
            memLoc = 5'b00001;
        end
        else begin
            if(songMem[memLoc][7]) begin //only play sound if instr starts with 1
                notecase <= songMem[memLoc][6:2];
                duration <= songMem[memLoc][1:0];
                memLoc <= memLoc+1;
            end
            else begin
                notecase <= 5'b0_1000;
                duration <= 2'b0;
                memLoc <= 5'b0;
            end
        end
    end
endmodule
