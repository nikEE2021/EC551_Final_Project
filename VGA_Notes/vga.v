`timescale 1ns / 1ns

`include "font_terminal.v"
`include "font_convertor.v"
`include "const.v"

module vga(
	input  [10:0] vga_h_ctr,
	input  [10:0] vga_v_ctr,
	output vga_pixel_on,
    
    input [7:0] key_stroke,

	input clk,
	input rst
	);

	 reg [7:0] init;
	 reg [5:0] init_char;
	 reg [7:0] init_h;
	 reg [7:0] init_v;
	 wire init_en;
	 localparam init_steps = 4;

    reg  [7:0]  note;
	reg  disp_counter;
	reg  [3:0] display_hex;
	reg  [5:0] display_char;
	wire [5:0] display_h;
	wire [5:0] display_v;

	wire [7:0] term_h;
	wire [7:0] term_v;
	wire [5:0] term_char;
	reg       term_w_en;

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

	always @(*) begin
		case (disp_counter)
			0: display_hex = note[7:4];
			1: display_hex = note[3:0];
			default: display_hex = 4'b0000;
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
			 7: display_char = `CHAR_7;
			 8: display_char = `CHAR_8;
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
	 			init_h <= 30;
	 			init_v <= 25;
	 			init_char <= `CHAR_N;
	 		end
	 		1: begin
	 			init_h <= 31; 
	 			init_v <= 25; 
	 			init_char <= `CHAR_O;
	 		end
	 		2: begin
	 			init_h <= 32; 
	 			init_v <= 25; 
	 			init_char <= `CHAR_T;
	 		end
	 		3: begin
	 			init_h <= 33; 
	 			init_v <= 25; 
	 			init_char <= `CHAR_E;
	 		end
	 		default: begin
	 		    term_w_en <= 0;
	 		end
	 	endcase
	 end
endmodule
