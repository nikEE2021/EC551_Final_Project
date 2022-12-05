`timescale 1ns / 1ns

`include "font_terminal.v"
`include "font_convertor.v"
`include "const.v"

module vga(
//    input music_box_mode,
	input  [10:0] vga_h_ctr,
	input  [10:0] vga_v_ctr,
    
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b,
    
    input [7:0] key_stroke,

	input clk,
	input rst
	);
    
	 reg [7:0] init;
	 reg [5:0] init_char;
	 reg [7:0] init_h;
	 reg [7:0] init_v;
	 wire init_en;
	 localparam init_steps = 157;
    
//    reg  [7:0]  mode;
    reg  [7:0]  note;
//	reg  [1:0] disp_counter;
	reg  disp_counter;
	reg  [3:0] display_hex;
	reg  [5:0] display_char;
	wire [7:0] display_h;
	wire [7:0] display_v;

    reg key_en;
    
	wire [7:0] term_h;
	wire [7:0] term_v;
	wire [5:0] term_char;
	reg       term_w_en;
    
    wire vga_pixel_on;
    
	font_terminal terminal_u0(
		.w_h_addr(term_h),
		.w_v_addr(term_v),
		.w_data(term_char),
		.w_en(term_w_en),

		.h_ctr(vga_h_ctr),
		.v_ctr(vga_v_ctr),
		.pixel_on(vga_pixel_on),

		.clk(clk),
		.rst(rst)
	);

	 assign init_en = (init != init_steps);
     
     assign term_h    = init_en ? init_h    : display_h;
	 assign term_v    = init_en ? init_v    : display_v;
	 assign term_char = init_en ? init_char : display_char;
	 
	assign display_h = disp_counter + 35;
	assign display_v = 25;
	
//	assign display_h = (disp_counter == 0) || (disp_counter == 1) ? disp_counter + 35 : 76;
//	assign display_v = (disp_counter == 0) || (disp_counter == 1) ? 25 : disp_counter - 2;
	
	assign vga_r = (vga_pixel_on) ? 4'h0 : 4'h0;
    assign vga_g = (vga_pixel_on) ? 4'hf : 4'h0;
    assign vga_b = (vga_pixel_on) ? 4'h0 : 4'h0;
    
	always @(posedge clk) begin
	   case(key_stroke[7:0])    
	       8'h1C: note <= 8'hC4; //C4
	       8'h1B: note <= 8'hD4; //D4
	       8'h23: note <= 8'hE4; //E4
	       8'h2B: note <= 8'hF4; //F4
	       8'h34: note <= 8'h94; //G4
	       8'h33: note <= 8'hA4; //A4
	       8'h3B: note <= 8'hB4; //B4
	       8'h42: note <= 8'hC5; //C5
	       default: note <= 8'h00;
	   endcase      
   	end
    
//    always @(posedge clk) begin
//        case (music_box_mode)
//            0: mode <= 8'h78;
//            1: mode <= 8'h87;
//        endcase
//    end
    
	always @(*) begin
		case (disp_counter)
			0: display_hex = note[7:4];
			1: display_hex = note[3:0];
//            2: display_hex = mode[7:4];
//            3: display_hex = mode[3:0];
			default: display_hex = 4'h0;
		endcase
	end

	always @(*) begin
		case(display_hex)
			 0: display_char = `CHAR_0;
			 1: display_char = `CHAR_1;
			 2: display_char = `CHAR_2;
			 3: display_char = `CHAR_3;
			 4: display_char = `CHAR_4;
			 5: display_char = `CHAR_5;
			 6: display_char = `CHAR_6;
			 7: display_char = `CHAR_Y;
			 8: display_char = `CHAR_N;
			 9: display_char = `CHAR_G;
			10: display_char = `CHAR_A;
			11: display_char = `CHAR_B;
			12: display_char = `CHAR_C;
			13: display_char = `CHAR_D;
			14: display_char = `CHAR_E;
			15: display_char = `CHAR_F;
		endcase
	end

	 always @(posedge clk) begin
	 	if (rst) begin
	 		init <= 0;
	 	end else if (init_en) begin
	 		init <= init + 1;
	 	end
	 end
	
	always @(posedge clk) begin
		if (rst) begin
			disp_counter <= 0;
		end else if (disp_counter >= 1) begin
			disp_counter <= 0;
		end else begin
			disp_counter <= disp_counter + 1;
		end
	end
    
	 always @(posedge clk) begin
	 	case (init)
	 	    0: begin
                term_w_en <= 1;
                init_h <= 0;
                init_v <= 0;
                init_char <= `CHAR_T;
            end
            1: begin
                term_w_en <= 1;
                init_h <= 1;
                init_v <= 0;
                init_char <= `CHAR_W;
            end
            2: begin
                term_w_en <= 1;
                init_h <= 2;
                init_v <= 0;
                init_char <= `CHAR_I;
            end
            3: begin
                term_w_en <= 1;
                init_h <= 3;
                init_v <= 0;
                init_char <= `CHAR_N;
            end
            4: begin
                term_w_en <= 1;
                init_h <= 4;
                init_v <= 0;
                init_char <= `CHAR_K;
            end
            5: begin
                term_w_en <= 1;
                init_h <= 5;
                init_v <= 0;
                init_char <= `CHAR_L;
            end
            6: begin
                term_w_en <= 1;
                init_h <= 6;
                init_v <= 0;
                init_char <= `CHAR_E;
            end
            7: begin
                term_w_en <= 1;
                init_h <= 8;
                init_v <= 0;
                init_char <= `CHAR_L;
            end
            8: begin
                term_w_en <= 1;
                init_h <= 9;
                init_v <= 0;
                init_char <= `CHAR_I;
            end
            9: begin
                term_w_en <= 1;
                init_h <= 10;
                init_v <= 0;
                init_char <= `CHAR_T;
            end
            10: begin
                term_w_en <= 1;
                init_h <= 11;
                init_v <= 0;
                init_char <= `CHAR_T;
            end
            11: begin
                term_w_en <= 1;
                init_h <= 12;
                init_v <= 0;
                init_char <= `CHAR_L;
            end
            12: begin
                term_w_en <= 1;
                init_h <= 13;
                init_v <= 0;
                init_char <= `CHAR_E;
            end
            13: begin
                term_w_en <= 1;
                init_h <= 15;
                init_v <= 0;
                init_char <= `CHAR_S;
            end
            14: begin
                term_w_en <= 1;
                init_h <= 16;
                init_v <= 0;
                init_char <= `CHAR_T;
            end
            15: begin
                term_w_en <= 1;
                init_h <= 17;
                init_v <= 0;
                init_char <= `CHAR_A;
            end
            16: begin
                term_w_en <= 1;
                init_h <= 18;
                init_v <= 0;
                init_char <= `CHAR_R;
            end
            17: begin				// 1
                init_h <= 0;
                init_v <= 1;
                init_char <= `CHAR_A;
            end
            18: begin				// 1
                init_h <= 1;
                init_v <= 1;
            end
            19: begin				// 5
                init_h <= 2;
                init_v <= 1;
                init_char <= `CHAR_G;
            end
            20: begin				// 5
                init_h <= 3;
                init_v <= 1;
            end
            21: begin				// 6
                init_h <= 4;
                init_v <= 1;
                init_char <= `CHAR_H;
            end
            22: begin				// 6
                init_h <= 5;
                init_v <= 1;
            end
            23: begin				// 5
                init_h <= 6;
                init_v <= 1;
                init_char <= `CHAR_G;
            end
            24: begin				// 4
                init_h <= 8;
                init_v <= 1;
                init_char <= `CHAR_F;
            end
            25: begin				// 4
                init_h <= 9;
                init_v <= 1;
            end
            26: begin				// 3
                init_h <= 10;
                init_v <= 1;
                init_char <= `CHAR_D;
            end
            27: begin				// 3
                init_h <= 11;
                init_v <= 1;
            end
            28: begin				// 2
                init_h <= 12;
                init_v <= 1;
                init_char <= `CHAR_S;
            end
            29: begin				// 2
                init_h <= 13;
                init_v <= 1;
            end
            30: begin				// 1
                init_h <= 14;
                init_v <= 1;
                init_char <= `CHAR_A;
            end
            
            31: begin
                init_h <= 0;
                init_v <= 3;
                init_char <= `CHAR_O;
            end
            32: begin
                init_h <= 1;
                init_v <= 3;
                init_char <= `CHAR_L;
            end
            33: begin
                init_h <= 2;
                init_v <= 3;
                init_char <= `CHAR_D;
            end
            34: begin
                init_h <= 4;
                init_v <= 3;
                init_char <= `CHAR_M;
            end
            35: begin
                init_h <= 5;
                init_v <= 3;
                init_char <= `CHAR_A;
            end
            36: begin
                init_h <= 6;
                init_v <= 3;
                init_char <= `CHAR_C;
            end
            37: begin
                init_h <= 7;
                init_v <= 3;
                init_char <= `CHAR_D;
            end
            38: begin
                init_h <= 8;
                init_v <= 3;
                init_char <= `CHAR_O;
            end
            39: begin
                init_h <= 9;
                init_v <= 3;
                init_char <= `CHAR_N;
            end
            40: begin
                init_h <= 10;
                init_v <= 3;
                init_char <= `CHAR_A;
            end
            41: begin
                init_h <= 11;
                init_v <= 3;
                init_char <= `CHAR_L;
            end
            42: begin
                init_h <= 12;
                init_v <= 3;
                init_char <= `CHAR_D;
            end
            43: begin
                init_h <= 14;
                init_v <= 3;
                init_char <= `CHAR_H;
            end
            44: begin
                init_h <= 15;
                init_v <= 3;
                init_char <= `CHAR_A;
            end
            45: begin
                init_h <= 16;
                init_v <= 3;
                init_char <= `CHAR_D;
            end
            46: begin
                init_h <= 18;
                init_v <= 3;
                init_char <= `CHAR_A;
            end
            47: begin
                init_h <= 20;
                init_v <= 3;
                init_char <= `CHAR_F;
            end
            48: begin
                init_h <= 21;
                init_v <= 3;
                init_char <= `CHAR_A;
            end
            49: begin
                init_h <= 22;
                init_v <= 3;
                init_char <= `CHAR_R;
            end
            50: begin
                init_h <= 23;
                init_v <= 3;
                init_char <= `CHAR_M;
            end
            
            51: begin					// 1
                init_h <= 0;
                init_v <= 4;
                init_char <= `CHAR_A;
            end
            52: begin					// 1
                init_h <= 1;
                init_v <= 4;
                init_char <= `CHAR_A;
            end
            53: begin					// 1
                init_h <= 2;
                init_v <= 4;
                init_char <= `CHAR_A;
            end
            54: begin					// 5
                init_h <= 3;
                init_v <= 4;
                init_char <= `CHAR_G;
            end
            55: begin					// 6
                init_h <= 4;
                init_v <= 4;
                init_char <= `CHAR_H;
            end
            56: begin					// 6
                init_h <= 5;
                init_v <= 4;
                init_char <= `CHAR_H;
            end
            57: begin					// 5
                init_h <= 6;
                init_v <= 4;
                init_char <= `CHAR_G;
            end
            58: begin					// 3
                init_h <= 8;
                init_v <= 4;
                init_char <= `CHAR_D;
            end
            59: begin					// 3
                init_h <= 9;
                init_v <= 4;
                init_char <= `CHAR_D;
            end
            60: begin					// 2
                init_h <= 10;
                init_v <= 4;
                init_char <= `CHAR_S;
            end
            61: begin					// 2
                init_h <= 11;
                init_v <= 4;
                init_char <= `CHAR_S;
            end
            62: begin					// 1
                init_h <= 12;
                init_v <= 4;
                init_char <= `CHAR_A;
            end
    
            63: begin					
                init_h <= 0;
                init_v <= 6;
                init_char <= `CHAR_O;
            end
            64: begin					
                init_h <= 1;
                init_v <= 6;
                init_char <= `CHAR_D;
            end
            65: begin					
                init_h <= 2;
                init_v <= 6;
                init_char <= `CHAR_E;
            end
            66: begin					
                init_h <= 4;
                init_v <= 6;
                init_char <= `CHAR_T;
            end
            67: begin					
                init_h <= 5;
                init_v <= 6;
                init_char <= `CHAR_O;
            end
            68: begin					
                init_h <= 7;
                init_v <= 6;
                init_char <= `CHAR_J;
            end
            69: begin					
                init_h <= 8;
                init_v <= 6;
                init_char <= `CHAR_O;
            end
            70: begin					
                init_h <= 9;
                init_v <= 6;
                init_char <= `CHAR_Y;
            end
            71: begin					// 3					
                init_h <= 0;
                init_v <= 7;
                init_char <= `CHAR_D;
            end
            72: begin					// 3
                init_h <= 1;
                init_v <= 7;
                init_char <= `CHAR_D;
            end
            73: begin					// 4
                init_h <= 2;
                init_v <= 7;
                init_char <= `CHAR_F;
            end
            74: begin					// 5
                init_h <= 3;
                init_v <= 7;
                init_char <= `CHAR_G;
            end
            75: begin					// 5					
                init_h <= 5;
                init_v <= 7;
            end
            76: begin					// 4
                init_h <= 6;
                init_v <= 7;
                init_char <= `CHAR_F;
            end
            77: begin					// 3
                init_h <= 7;
                init_v <= 7;
                init_char <= `CHAR_D;
            end
            78: begin					// 2
                init_h <= 8;
                init_v <= 7;
                init_char <= `CHAR_S;
            end
            79: begin					// 1					
                init_h <= 10;
                init_v <= 7;
                init_char <= `CHAR_A;
            end
            80: begin					// 1
                init_h <= 11;
                init_v <= 7;
            end
            81: begin					// 2
                init_h <= 12;
                init_v <= 7;
                init_char <= `CHAR_S;
            end
            82: begin					// 3
                init_h <= 13;
                init_v <= 7;
                init_char <= `CHAR_D;
            end
            83: begin					// 3
                init_h <= 15;
                init_v <= 7;
            end
            84: begin					// 2
                init_h <= 16;
                init_v <= 7;
                init_char <= `CHAR_S;
            end
            85: begin					// 2
                init_h <= 17;
                init_v <= 7;
            end
            
            86: begin					
                init_h <= 0;
                init_v <= 9;
                init_char <= `CHAR_J;
            end
            87: begin					
                init_h <= 1;
                init_v <= 9;
                init_char <= `CHAR_A;
            end
            88: begin					
                init_h <= 2;
                init_v <= 9;
                init_char <= `CHAR_S;
            end
            89: begin					
                init_h <= 3;
                init_v <= 9;
                init_char <= `CHAR_M;
            end
            90: begin					
                init_h <= 4;
                init_v <= 9;
                init_char <= `CHAR_I;
            end
            91: begin					
                init_h <= 5;
                init_v <= 9;
                init_char <= `CHAR_N;
            end
            92: begin					
                init_h <= 6;
                init_v <= 9;
                init_char <= `CHAR_E;
            end
            93: begin					// 3
                init_h <= 0;
                init_v <= 10;
                init_char <= `CHAR_D;
            end
            94: begin					// 3
                init_h <= 2;
                init_v <= 10;
            end
            95: begin					// 5
                init_h <= 3;
                init_v <= 10;
                init_char <= `CHAR_G;
            end
            96: begin					// 6
                init_h <= 5;
                init_v <= 10;
                init_char <= `CHAR_H;
            end
            97: begin					// 8
                init_h <= 6;
                init_v <= 10;
                init_char <= `CHAR_K;
            end
            98: begin					// 8
                init_h <= 8;
                init_v <= 10;
            end
            99: begin					// 6
                init_h <= 9;
                init_v <= 10;
                init_char <= `CHAR_H;
            end
            100: begin					// 5
                init_h <= 11;
                init_v <= 10;
                init_char <= `CHAR_G;
            end
            101: begin					// 5
                init_h <= 13;
                init_v <= 10;
            end
            102: begin					// 6
                init_h <= 14;
                init_v <= 10;
                init_char <= `CHAR_H;
            end
            103: begin					// 5
                init_h <= 16;
                init_v <= 10;
                init_char <= `CHAR_G;
            end
            
            104: begin                   
                init_h <= 0;
                init_v <= 12;
                init_char <= `CHAR_J;
            end
            105: begin                   
                init_h <= 1;
                init_v <= 12;
                init_char <= `CHAR_I;
            end
            106: begin                   
                init_h <= 2;
                init_v <= 12;
                init_char <= `CHAR_N;
            end
            107: begin                   
                init_h <= 3;
                init_v <= 12;
                init_char <= `CHAR_G;
            end
            108: begin                   
                init_h <= 4;
                init_v <= 12;
                init_char <= `CHAR_L;
            end
            109: begin                   
                init_h <= 5;
                init_v <= 12;
                init_char <= `CHAR_E;
            end
            110: begin                   
                init_h <= 7;
                init_v <= 12;
                init_char <= `CHAR_B;
            end
            111: begin                   
                init_h <= 8;
                init_v <= 12;
                init_char <= `CHAR_E;
            end
            112: begin                   
                init_h <= 9;
                init_v <= 12;
                init_char <= `CHAR_L;
            end
            113: begin                   
                init_h <= 10;
                init_v <= 12;
                init_char <= `CHAR_L;
            end
            114: begin                   
                init_h <= 11;
                init_v <= 12;
                init_char <= `CHAR_S;
            end
            115: begin              // 3     
                init_h <= 0;
                init_v <= 13;
                init_char <= `CHAR_D;
            end
            116: begin              // 3     
                init_h <= 1;
                init_v <= 13;
                init_char <= `CHAR_D;
            end
            117: begin              // 3     
                init_h <= 2;
                init_v <= 13;
                init_char <= `CHAR_D;
            end
            118: begin              // 3     
                init_h <= 4;
                init_v <= 13;
                init_char <= `CHAR_D;
            end
            119: begin              // 3     
                init_h <= 5;
                init_v <= 13;
                init_char <= `CHAR_D;
            end
            120: begin              // 3     
                init_h <= 6;
                init_v <= 13;
                init_char <= `CHAR_D;
            end
            121: begin              // 3     
                init_h <= 8;
                init_v <= 13;
                init_char <= `CHAR_D;
            end
            122: begin              // 5     
                init_h <= 9;
                init_v <= 13;
                init_char <= `CHAR_G;
            end
            123: begin              // 1     
                init_h <= 10;
                init_v <= 13;
                init_char <= `CHAR_A;
            end
            124: begin              // 2     
                init_h <= 11;
                init_v <= 13;
                init_char <= `CHAR_S;
            end
            125: begin              // 3     
                init_h <= 12;
                init_v <= 13;
                init_char <= `CHAR_D;
            end

	 		126: begin
	 			term_w_en <= 1;
	 			init_h <= 30;
	 			init_v <= 25;
	 			init_char <= `CHAR_N;
	 		end
	 		127: begin
	 			init_h <= 31; 
	 			init_v <= 25; 
	 			init_char <= `CHAR_O;
	 		end
	 		128: begin
	 			init_h <= 32; 
	 			init_v <= 25; 
	 			init_char <= `CHAR_T;
	 		end
	 		129: begin
	 			init_h <= 33; 
	 			init_v <= 25; 
	 			init_char <= `CHAR_E;
	 		end
            
            130: begin
                init_h <= 59; 
                init_v <= 0; 
                init_char <= `CHAR_U;
            end
            131: begin
                init_h <= 60; 
                init_v <= 0; 
                init_char <= `CHAR_S;
            end
            132: begin
                init_h <= 61; 
                init_v <= 0; 
                init_char <= `CHAR_E;
            end
            133: begin
                init_h <= 62; 
                init_v <= 0; 
                init_char <= `CHAR_R;
            end
            134: begin
                init_h <= 63; 
                init_v <= 0; 
                init_char <= `CHAR_SPACE;
            end
            135: begin
                init_h <= 64; 
                init_v <= 0; 
                init_char <= `CHAR_I;
            end
            136: begin
                init_h <= 65; 
                init_v <= 0; 
                init_char <= `CHAR_N;
            end
            137: begin
                init_h <= 66; 
                init_v <= 0; 
                init_char <= `CHAR_P;
            end
            138: begin
                init_h <= 67; 
                init_v <= 0; 
                init_char <= `CHAR_U;
            end
            139: begin
                init_h <= 68; 
                init_v <= 0; 
                init_char <= `CHAR_T;
            end
            140: begin
                init_h <= 70; 
                init_v <= 0; 
                init_char <= `CHAR_M;
            end
            141: begin
                init_h <= 71; 
                init_v <= 0; 
                init_char <= `CHAR_O;
            end
            142: begin
                init_h <= 72; 
                init_v <= 0; 
                init_char <= `CHAR_D;
            end
            143: begin
                init_h <= 73; 
                init_v <= 0; 
                init_char <= `CHAR_E;
            end
            
            144: begin
                init_h <= 60; 
                init_v <= 1; 
                init_char <= `CHAR_M;
            end
            145: begin
                init_h <= 61; 
                init_v <= 1; 
                init_char <= `CHAR_U;
            end
            146: begin
                init_h <= 62; 
                init_v <= 1; 
                init_char <= `CHAR_S;
            end
            147: begin
                init_h <= 63; 
                init_v <= 1; 
                init_char <= `CHAR_I;
            end
            148: begin
                init_h <= 64; 
                init_v <= 1; 
                init_char <= `CHAR_C;
            end
            149: begin
                init_h <= 66; 
                init_v <= 1; 
                init_char <= `CHAR_B;
            end
            150: begin
                init_h <= 67; 
                init_v <= 1; 
                init_char <= `CHAR_O;
            end
            151: begin
                init_h <= 68; 
                init_v <= 1; 
                init_char <= `CHAR_X;
            end
            152: begin
                init_h <= 70; 
                init_v <= 1; 
                init_char <= `CHAR_M;
            end
            153: begin
                init_h <= 71; 
                init_v <= 1; 
                init_char <= `CHAR_O;
            end
            154: begin
                init_h <= 72; 
                init_v <= 1; 
                init_char <= `CHAR_D;
            end
            155, 156: begin
                init_h <= 73; 
                init_v <= 1; 
                init_char <= `CHAR_E;
            end
        endcase
	 end
endmodule
