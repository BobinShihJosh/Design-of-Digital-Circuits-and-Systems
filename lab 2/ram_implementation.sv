module ram_implementation #(parameter addr_width = 5, data_width = 4) 
				(input logic Clock, 
				 input logic Write,
				 input logic [addr_width-1:0] Address,
				 input logic [data_width-1:0] DataIn,
				 output logic [data_width-1:0] DataOut);
				 
	 RAM32x4 ram(.address(Address), .clock(Clock), .data(DataIn), .wren(Write), .q(DataOut));
				 
endmodule

`timescale 1 ps/1 ps
module ram_implementation_testbench();
 logic Clock;
 logic Write;
 logic [4:0] Address;
 logic [3:0] DataIn;
 logic [3:0] DataOut;

ram_implementation dut (.Clock, .Write, .Address, .DataIn, .DataOut);

 // Set up the clock.
parameter CLOCK_PERIOD=100;
initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
		Write <= 1; Address <= 5'b00001; DataIn <= 4'b0110; @(posedge Clock);//write is enabled 
				      Address <= 5'b00011; DataIn <= 4'b0111; @(posedge Clock);//values should be able to be written and read
		Write <= 0; Address <= 5'b01111; DataIn <= 4'b1110; @(posedge Clock);//write is not enabled
					   Address <= 5'b11001; DataIn <= 4'b1110; @(posedge Clock);//values should not be able to be written and read
		Write <= 1; Address <= 5'b01101; DataIn <= 4'b1110; @(posedge Clock);// write is enabled
						Address <= 5'b01101; DataIn <= 4'b0011; @(posedge Clock);//values should be able to be written and read
								
						 
$stop; // End the simulation.
 end
 endmodule
 