`timescale 1ns / 1ps

module main_test(
    input clk,
    input PS2Clk,
    input PS2Data,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b,
    output vga_hsync,
    output vga_vsync
    );
    
    wire [31:0] KeyboardOut;
    
    KeyboardClkDivider kcd(.clkin(clk),.rst(rst),.clkout(kclk));
    
    PS2Receiver keyboard(.clk(kclk),.kclk(PS2Clk),.kdata(PS2Data),.keycodeout(KeyboardOut));
    
    wire [10:0] vga_h_counter;
    wire [10:0] vga_v_counter;
    wire vga_pixel;
    wire vga_blank;
    
    assign vga_r = (vga_pixel) ? 4'hf : 4'h0;
    assign vga_g = (vga_pixel) ? 4'hf : 4'h0;
    assign vga_b = (vga_pixel) ? 4'hf : 4'h0;
        
    vga vga_display(.clk(clk),.rst(rst),.key_stroke(KeyboardOut[7:0]),.vga_h_ctr(vga_h_counter),.vga_v_ctr(vga_v_counter),.vga_pixel_on(vga_pixel));
    
    vga_controller_640_60 vga_ctrl(
        .HS(vga_hsync),
        .VS(vga_vsync),
        .hcounter(vga_h_counter),
        .vcounter(vga_v_counter),
        .pixel_clk(clk),
        .blank(vga_blank)
    );
    
endmodule
