`timescale 1ns / 1ns

`include "font_convertor.v"
`include "const.v"

module font_terminal(
	input [ 7:0] w_h_addr,
	input [ 7:0] w_v_addr,
	input [ 5:0] w_data,
	input w_en,

	input [10:0] h_ctr,
	input [10:0] v_ctr,
	output pixel_on,

	input clk,
	input rst
 	);

	reg [5:0] charsel;
	reg [5:0] char_buffer [127:0] [127:0];

	font_convertor convertor_u0(
		.hscan_lo(h_ctr[2:0]),
		.vscan_lo(v_ctr[2:0]),
		.charsel(charsel),
		.out(pixel_on),
		.clk(clk),
		.rst(rst)
	);
	
	always @(posedge clk) begin
		charsel <= char_buffer[v_ctr[10:3]][h_ctr[10:3]];
	end

	always @(posedge clk) begin
		if (rst) begin
		end else if (w_en) begin
			char_buffer[w_v_addr][w_h_addr] <= w_data;
		end
	end
endmodule
