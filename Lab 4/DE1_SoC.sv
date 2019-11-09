module DE1_SoC (CLOCK_50, GPIO_0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [35:0] GPIO_0;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
	// intermediate logic between control and datapath
	logic [7:0] currentA;
	logic lookHigh, lookLow, rst_bnd, foundA;
	logic [4:0] address;
	logic [7:0] ramData;
	
	assign LEDR[9] = foundA;
	
	// map reset to key 
	logic reset;
	assign reset = ~KEY[0];
	
	// map start to switch 9  
	logic start;
	assign start = SW[9];
	
	// map A to switches 0 - 7 
	logic [7:0] A;
	assign A = SW[7:0];
	
	// map A address to HEX'S depending on if A is found
	logic [6:0] HEX_0, HEX_1;
	
	assign HEX0 = (foundA)? HEX_0 : 7'b1111111;
	assign HEX1 = (foundA)? HEX_1 : 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

	// clock divider
	logic [31:0] clk;
	parameter whichClock = 15;
	clock_divider cdiv (.clock(CLOCK_50), .Reset(Reset), .divided_clocks(clk)); // comment out for modelsim
	
	// Map addr to hex0 and hex 1 if A is found 
	HexDisplay hexdis(.addr(address), .Czero(HEX_0), .Cone(HEX_1));
	
	// Get data out of ram to use in data path
	RAM_32X8 ram32x8(.address(address), .clock(CLOCK_50), .data(8'd0), .wren(1'b0), .q(ramData));	
	
	// datapath 
	dataPath dapa(.clk(clk[whichClock]), .lookDown(lookLow), .lookUp(lookHigh), .rst(rst_bnd), 
				 .din_ram(ramData), .A_addr(address), .currA(currentA));
 
	// control logic FSM
	control ctrl(.clk(clk[whichClock]), .reset(reset), .start(start), .A(A), .currA(currentA),
				.FOUND(foundA), .lookDown(lookLow), .lookUp(lookHigh), .rst(rst_bnd));		
	
endmodule

 // divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, Reset, divided_clocks);
	input logic Reset, clock;
	output logic [31:0] divided_clocks = 0;

	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	end
endmodule	


module DE1_SoC_testbench();
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [35:0] GPIO_0;
 logic [9:0] LEDR;
 logic [3:0] KEY; // True when not pressed, False when pressed
 logic [9:0] SW;
 logic clk;

DE1_SoC dut (.CLOCK_50(clk), .GPIO_0, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);

 // Set up the clock.
parameter CLOCK_PERIOD=100;
initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
end

// testing two values that can be found and testing one that can't be found. 
initial begin 
			KEY[0]<=0;										@(posedge clk);
			KEY[0]<=1;										@(posedge clk);
			SW[9]<=1;										@(posedge clk);
			SW[9]<=0;										@(posedge clk);
							SW[7:0]<=8'b00000011;		@(posedge clk);
																@(posedge clk);
			SW[9]<=1;										@(posedge clk);
			SW[9]<=0;										@(posedge clk);
																@(posedge clk);
						   SW[7:0]<=8'b00000111;		@(posedge clk);
																@(posedge clk);
			SW[9]<=1;										@(posedge clk);
			SW[9]<=0;										@(posedge clk);
																@(posedge clk);
							SW[7:0]<=8'b0101111;			@(posedge clk);
																@(posedge clk);
			SW[9]<=1;										@(posedge clk);
			SW[9]<=0;										@(posedge clk);
																@(posedge clk);	
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
			$stop;
	end


endmodule
