module ram3_DE1(CLOCK_50, GPIO_0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 input logic CLOCK_50; // 50MHz clock.
 output logic [35:0] GPIO_0;
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input logic [3:0] KEY; // True when not pressed, False when pressed
 input logic [9:0] SW;
  
 // Generate clk off of CLOCK_50, whichClock picks rate.
 parameter whichClock = 25;
 logic [31:0] clk;
 logic [3:0] DataOut; //tmp var for output of ram and input to display
 logic [4:0] addr_display; //tmp var for address according to the counter
 
 clock_divider cdiv (.clock(CLOCK_50), .Reset(reset), .divided_clocks(clk));//clock dividder module
 
 //creates a counter that goes through ram address and controls the output display at a one second frequency
 counter cnt(.clock(clk[whichClock]), .reset(~KEY[0]), .out(addr_display)); 
 //creates ram that takes writes and reads
 Ram32x2_2prt rm(.clock(CLOCK_50), .data(SW[3:0]), .rdaddress(addr_display), .wraddress(SW[8:4]), .wren(SW[9]), .q(DataOut));
 
 // displays each HEX respectively
 displayHex w_addr5(.in({1'b0, 1'b0, 1'b0, SW[8]}), .display(HEX5));
 displayHex w_addr4(.in(SW[7:4]), .display(HEX4));
 displayHex d_addr3(.in({1'b0, 1'b0, 1'b0, addr_display[4]}), .display(HEX3));
 displayHex d_addr2(.in(addr_display[3:0]), .display(HEX2));
 displayHex W_data(.in(SW[3:0]), .display(HEX1));
 displayHex num(.in(DataOut), .display(HEX0));
				 
endmodule

module clock_divider (clock, Reset, divided_clocks);
 input logic Reset, clock;
 output logic [31:0] divided_clocks = 0;

 always_ff @(posedge clock) begin
 divided_clocks <= divided_clocks + 1;
 end

endmodule
`timescale 1 ps/1 ps
module ram3_DE1_testbench();
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [35:0] GPIO_0;
 logic [9:0] LEDR;
 logic [3:0] KEY; // True when not pressed, False when pressed
 logic [9:0] SW;
 logic Clock;

ram3_DE1 dut (CLOCK_50, GPIO_0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

parameter CLOCK_PERIOD = 50;
	initial begin Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
	KEY[0]<=0;												  		   @(posedge Clock); 
				 SW[9]<=1;SW[8:4]<=5'b00001;SW[3:0]<=4'b0101;@(posedge Clock); //									
   
				 SW[9]<=1;SW[8:4]<=5'b00101;SW[3:0]<=4'b0111;@(posedge Clock);
	
				 SW[9]<=1;SW[8:4]<=5'b00111;SW[3:0]<=4'b0100;@(posedge Clock);
	
				 SW[9]<=1;SW[8:4]<=5'b00100;SW[3:0]<=4'b1101;@(posedge Clock);
	
				 SW[9]<=1;SW[8:4]<=5'b10001;SW[3:0]<=4'b1100;@(posedge Clock);
	
				 SW[9]<=0;SW[8:4]<=5'b01001;SW[3:0]<=4'b0110;@(posedge Clock);
	
				 SW[9]<=0;SW[8:4]<=5'b10110;SW[3:0]<=4'b1111;@(posedge Clock);
						 
						 
 $stop; // End the simulation.
 end
 endmodule
 