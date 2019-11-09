module ram2_DE1(CLOCK_50, GPIO_0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 input logic CLOCK_50; // 50MHz clock.
 output logic [35:0] GPIO_0;
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input logic [3:0] KEY; // True when not pressed, False when pressed
 input logic [9:0] SW;
  
 // Generate clk off of CLOCK_50, whichClock picks rate.
 logic [31:0] clk;
 logic [6:0] HEX_0, HEX_2, HEX_4, HEX_5;
 logic [3:0] DataOut;
				 
 ram_mem mem(.address(SW[8:4]), .clock(~KEY[0]), .data(SW[3:0]), .wren(SW[9]), .q(DataOut));
 
 displayHex addr5(.in({1'b0, 1'b0, 1'b0, SW[8]}), .display(HEX_5));
 displayHex addr4(.in(SW[7:4]), .display(HEX_4));
 displayHex din(.in(SW[3:0]), .display(HEX_2));
 displayHex dout(.in(DataOut), .display(HEX_0));
 
 assign HEX0 = HEX_0;
 assign HEX1 = 7'b1111111;
 assign HEX2 = HEX_2;
 assign HEX3 = 7'b1111111;
 assign HEX4 = HEX_4;
 assign HEX5 = HEX_5;
 
				 
endmodule

//`timescale 1 ps/1 ps
module ram2_DE1_testbench();
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [35:0] GPIO_0;
 logic [9:0] LEDR;
 logic [3:0] KEY; // True when not pressed, False when pressed
 logic [9:0] SW;
 logic Clock;

ram2_DE1 dut (CLOCK_50, GPIO_0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

parameter delay = 10;

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
	KEY[0] = 0; SW[9] = 1; SW[8:4] = 5'b00001; SW[3:0] = 4'b0111; #delay;
	KEY[0] = 1;																	  #delay;
	KEY[0] = 0; SW[9] = 1; SW[8:4] = 5'b00101; SW[3:0] = 4'b0101; #delay;
	KEY[0] = 1;																	  #delay;
	KEY[0] = 0; SW[9] = 1; SW[8:4] = 5'b11001; SW[3:0] = 4'b1001; #delay;
	KEY[0] = 1;																	  #delay;	
	KEY[0] = 0; SW[9] = 0; SW[8:4] = 5'b00001; SW[3:0] = 4'b1011; #delay;
	KEY[0] = 1;																	  #delay;	
	KEY[0] = 0; SW[9] = 0; SW[8:4] = 5'b00101; SW[3:0] = 4'b1111; #delay;
	KEY[0] = 1;																	  #delay;	
	KEY[0] = 0; SW[9] = 0; SW[8:4] = 5'b11001; SW[3:0] = 4'b1101; #delay;
	KEY[0] = 1;																		  #delay;	
								
						 
 $stop; // End the simulation.
 end
 endmodule
 