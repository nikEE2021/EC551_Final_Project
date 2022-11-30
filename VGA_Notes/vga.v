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
	localparam init_steps = 15;

    reg  [7:0]  note;
	reg  [4:0] register_disp_counter;
	reg  [3:0] register_hex;
	reg  [5:0] register_char;
	wire [5:0] register_h;
	wire [5:0] register_v;

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

	assign term_h    = init_en ? init_h    : register_h;
	assign term_v    = init_en ? init_v    : register_v;
	assign term_char = init_en ? init_char : register_char;

	assign register_h = register_disp_counter[1:0] + 3;
	assign register_v = register_disp_counter[4:2];
	
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
		case (register_disp_counter)
			 0: register_hex = note[7:4];
			 1: register_hex = note[3:0];
			 2: register_hex = note[ 7: 4];
			 3: register_hex = note[ 3: 0];
			 4: register_hex = note[ 7: 4];
			 5: register_hex = note[ 3: 0];
			 6: register_hex = note[ 7: 4];
			 7: register_hex = note[ 3: 0];
			 8: register_hex = note[7:4];
			 9: register_hex = note[3:0];
			10: register_hex = note[ 7: 4];
			11: register_hex = note[ 3: 0];
			12: register_hex = note[7:4];
			13: register_hex = note[3:0];
			14: register_hex = note[ 7: 4];
			15: register_hex = note[ 3: 0];
			16: register_hex = note[7:4];
			17: register_hex = note[3: 0];
			18: register_hex = note[ 7: 4];
			19: register_hex = note[ 3: 0];
			20: register_hex = note[7:4];
			21: register_hex = note[3: 0];
			22: register_hex = note[ 7: 4];
			23: register_hex = note[ 3: 0];
			24: register_hex = note[7:4];
			25: register_hex = note[3: 0];
			26: register_hex = note[ 7: 4];
			27: register_hex = note[ 3: 0];
			default: register_hex = 4'b0000;
		endcase
	end

	always @(*) begin
		case(register_hex)
			 0: register_char = `CHAR_0;
			 1: register_char = `CHAR_1;
			 2: register_char = `CHAR_2;
			 3: register_char = `CHAR_3;
			 4: register_char = `CHAR_4;
			 5: register_char = `CHAR_5;
			 6: register_char = `CHAR_6;
			 7: register_char = `CHAR_7;
			 8: register_char = `CHAR_8;
			 9: register_char = `CHAR_9;
			10: register_char = `CHAR_A;
			11: register_char = `CHAR_B;
			12: register_char = `CHAR_C;
			13: register_char = `CHAR_D;
			14: register_char = `CHAR_E;
			15: register_char = `CHAR_F;
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
			register_disp_counter <= 0;
		end else if (register_disp_counter >= 27) begin
			register_disp_counter <= 0;
		end else begin
			register_disp_counter <= register_disp_counter + 1;
		end
	end

	always @(posedge clk) begin
		case (init)
			0: begin
				term_w_en <= 1;
				init_h <= 0;
				init_v <= 0;
				init_char <= `CHAR_N;
			end
			1, 2, 3, 4, 5, 6: init_v <= init_v + 1;
			7: begin
				init_h <= 1; 
				init_v <= 0; 
				init_char <= `CHAR_0;
			end
			8, 9, 10, 11, 12, 13, 14: begin
				init_v <= init_v + 1;
				init_char <= init_char + 1;
			end
		endcase
	end
endmodule
