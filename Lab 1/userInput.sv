module userInput (clk, Reset, en, ex, cen, cex);
 input logic clk, Reset;
 input logic en, ex;
 output logic cen, cex;
 
 // seperate calls on the same module that makes sure userinput presses are true for only one clock preiod.
 keys enter(.clk, .Reset, .key(en), .out(cen)); // input key press output clocked signal enter
 keys exit(.clk, .Reset, .key(ex), .out(cex)); // input key press output clocked signal exit
 
endmodule

module userInput_testbench();
 logic clk, Reset;
 logic en, ex;
 logic cen, cex;

userInput dut (clk, Reset, en, ex, cen, cex);

 // Set up the clock.
parameter CLOCK_PERIOD=100;
initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
											@(posedge clk);
 Reset <= 1;			   			@(posedge clk);// gives an enter longer than one cycle and see if it outputs the enter signal fir only one clock cycle
 Reset <= 0;      en = 1; ex = 0;@(posedge clk);
						en = 1; ex = 0;@(posedge clk);
						en = 1; ex = 0;@(posedge clk);
						en = 1; ex = 0;@(posedge clk);
						en = 0; ex = 1;@(posedge clk);
						en = 0; ex = 1;@(posedge clk);
						en = 0; ex = 1;@(posedge clk);
						en = 0; ex = 1;@(posedge clk);
						en = 0; ex = 1;@(posedge clk);
						en = 0; ex = 1;@(posedge clk);
	
						
						
						
$stop; // End the simulation.
 end
endmodule
