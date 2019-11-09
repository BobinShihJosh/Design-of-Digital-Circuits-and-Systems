module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign LEDR = SW;
	
	assign reset = SW[9];
	assign clear = SW[8];
	
	logic [10:0] x0, y0, x1, y1, x, y;
	
	logic [10:0] x_clr, y_clr;
	
	logic [10:0] X, Y;

	logic color;
	
	logic [31:0] clk;
	parameter whichClock = 21;
	clock_divider cdiv (.clock(CLOCK_50), .Reset(Reset), .divided_clocks(clk));
	
	//Clear Logic 
	always_ff @(posedge CLOCK_50) begin
		if (x_clr == 640 && y_clr == 480) begin
			x_clr <= 0;
			y_clr <= 0;
		end else if (y_clr == 480) begin
			x_clr <= x_clr + 1'b1;
			y_clr <= 0;
		end else begin
			x_clr <= x_clr; 
			y_clr <= y_clr + 1'b1;
		end
	end		
	
	/*
	logic to decide if VGA buffer should be taking the input to clear the screen
	or to draw the line animation.
	*/
	
	always_comb begin
		if (clear) begin
			x = x_clr;
			y = y_clr;
			color = 0;
		end else if (clk[whichClock]) begin
			x = X;
			y = Y;
			color = 1;
		end else begin
			x = x_clr;
			y = y_clr;
			color = 0;
		end
	end
	
	
	/*
		animation logic 
	*/
	logic [10:0] x0_ani = 370, y0_ani = 240, x1_ani = 400, y1_ani = 240;
	always_ff @(posedge clk[whichClock]) begin
		if (x0_ani == 420) begin
			x0_ani <= 0;
			y0_ani <= 0;
			x1_ani <= 0;
			y1_ani <= 250;
		end else if (y1_ani == 420 )begin
			x0_ani <= 100;
			y0_ani <= 20;
			x1_ani <= 20;
			y1_ani <= 100;
		end else begin
			x0_ani <= x0_ani + 7;
			y0_ani <= y0_ani + 5;
			x1_ani <= x1_ani + 3;
			y1_ani <= y1_ani + 1;
		end
	end
				
	line_drawer lines (.clk(CLOCK_50), .reset(~clk[whichClock]),
				.x0(x0_ani), .y0(y0_ani), .x1(x1_ani), .y1(y1_ani), .x(X), .y(Y));
	
	VGA_framebuffer fb(.clk50(CLOCK_50), .reset(1'b0), .x, .y,
				.pixel_color(color), .pixel_write(1'b1),
				.VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_HS, .VGA_VS,
				.VGA_BLANK_n(VGA_BLANK_N), .VGA_SYNC_n(VGA_SYNC_N));
	
	
	
endmodule

 // divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, Reset, divided_clocks);
	input logic Reset, clock;
	output logic [31:0] divided_clocks = 0;

	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	end

endmodule
