module parkingLot(clk, Reset, a, b, en, ex);
	input logic clk, Reset, a, b;
	output logic en, ex;
	
	// enumerations of the states
	enum {s00, s01, s10, s11} ps, ns;
	
	// combination logic that does exactly the state diagram which describes exactly 
	// the present state and next state depending on the input
	always_comb begin
		case(ps)
			s00: if (a&~b) ns = s10;
				  else if (~a&b) ns = s01;
				  else ns = s00;
			s01: if (~a&~b) ns = s00;
				  else if (a&b) ns = s11;
				  else ns = s01;
			s10: if (a&b) ns = s11;
			     else if (~a&~b) ns = s00;
				  else ns = s10;
			s11: if (~a&b) ns = s01;
				  else if (a&~b) ns = s10;
				  else ns = s11;
		endcase
	end
	
	
	// describes the condition in which enter is true or exit is true and assigns accordingly
	assign en = ((ps == s01) & (~a&~b));
	assign ex = ((ps == s10) & (~a&~b));
	
	// sequentional logic that clocks the changes of state at a positive clock edge
	always_ff @(posedge clk) begin
		if (Reset)
			ps <= s00;
		else 
			ps <= ns;
	end
	
	
endmodule


// test bench
module parkingLot_testbench();
 logic clk, Reset, a, b, en, ex;

 parkingLot dut (.clk, .Reset, .a, .b, .en, .ex);

 parameter CLOCK_PERIOD = 100;
 
 initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
 end
 
 initial begin
									  @(posedge clk);
								
	Reset <= 1;					  @(posedge clk);
	
	Reset <= 0;    a<=0;b<=0;@(posedge clk); // simulate car entering
	
						a<=1;b<=0;@(posedge clk);// simulate car entering
						
						a<=1;b<=1;@(posedge clk);
						
						a<=0;b<=1;@(posedge clk);
						
						a<=0;b<=0;@(posedge clk); // car enters, en = 1'b1
						
						a<=1;b<=0;@(posedge clk);
						
						a<=1;b<=1;@(posedge clk);
						
						a<=0;b<=1;@(posedge clk);
						
						a<=0;b<=0;@(posedge clk); // car enters, en = 1'b1
						
						a<=0;b<=0;@(posedge clk); // simulate car exiting
						
						a<=0;b<=1;@(posedge clk);
						
						a<=1;b<=1;@(posedge clk);
						
						a<=1;b<=0;@(posedge clk);
						
						a<=0;b<=0;@(posedge clk); // car exits, ex = 1'b1
						
						a<=0;b<=0;@(posedge clk);
			  
	$stop;
 end
endmodule
