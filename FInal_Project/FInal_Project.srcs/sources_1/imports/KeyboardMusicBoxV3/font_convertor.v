`timescale 1ns / 1ns
`include "const.v"

module font_convertor(
	input  [2:0] hscan_lo,
	input  [2:0] vscan_lo,
	input  [5:0] charsel,

	output out,

	input clk,
	input rst
	);

	reg  [7:0] char_img [(8*64)-1:0];
	wire [7:0] char_cur [7:0];
	wire [8:0] char_addr;

	assign char_addr = {charsel, 3'b000};

	genvar ii;
	generate
		for (ii=0; ii<8; ii=ii+1) begin: asn_char
			assign char_cur[ii] = char_img[char_addr + ii];
		end
	endgenerate

	assign out = char_cur[vscan_lo][7-hscan_lo];

	initial begin
		$readmemb("char.list", char_img);
	end
endmodule
