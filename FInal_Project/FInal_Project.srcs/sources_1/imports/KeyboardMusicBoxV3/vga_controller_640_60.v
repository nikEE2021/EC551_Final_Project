`timescale 1ns / 1ps

// Generate HS, VS signals from pixel clock.
// hcounter & vcounter are the index of the current pixel 
// origin (0, 0) at top-left corner of the screen
// valid display range for hcounter: [0, 640)
// valid display range for vcounter: [0, 480)
module vga_controller_640_60 (pixel_clk,HS,VS,hcounter,vcounter,blank);

	input pixel_clk;
	output HS, VS, blank;
	output [10:0] hcounter, vcounter;

	parameter HMAX = 800; // maximum value for the horizontal pixel counter
	parameter VMAX = 525; // maximum value for the vertical pixel counter
	parameter HLINES = 640; // total number of visible columns
	parameter HFP = 648; // value for the horizontal counter where front porch ends
	parameter HSP = 744; // value for the horizontal counter where the synch pulse ends
	parameter VLINES = 480; // total number of visible lines
	parameter VFP = 482; // value for the vertical counter where the front porch ends
	parameter VSP = 484; // value for the vertical counter where the synch pulse ends
	parameter SPP = 0;


	wire video_enable;
	reg HS,VS,blank;
	reg [10:0] hcounter,vcounter;

	reg pixel_clk_25M;
	reg [1:0] count;
	always@(posedge pixel_clk) begin
		count <= count + 1'b1;
		pixel_clk_25M <= count[1];
	end

	always@(posedge pixel_clk_25M)begin
		blank <= ~video_enable; 
	end

	always@(posedge pixel_clk_25M)begin
		if (hcounter == HMAX) hcounter <= 0;
		else hcounter <= hcounter + 1;
	end

	always@(posedge pixel_clk_25M)begin
		if(hcounter == HMAX) begin
			if(vcounter == VMAX) vcounter <= 0;
			else vcounter <= vcounter + 1; 
		end
	end

	always@(posedge pixel_clk_25M)begin
		if(hcounter >= HFP && hcounter < HSP) HS <= SPP;
		else HS <= ~SPP; 
	end

	always@(posedge pixel_clk_25M)begin
		if(vcounter >= VFP && vcounter < VSP) VS <= SPP;
		else VS <= ~SPP; 
	end

	assign video_enable = (hcounter < HLINES && vcounter < VLINES) ? 1'b1 : 1'b0;

endmodule
