module keys (clk, Reset, key, out);
 input logic clk, Reset, key;
 output logic out;
 
logic ns, FF1Out;
 
 
 // combinational logic that clocks userinput presses to be true for only one clock period
always_comb begin
	case(out) 
		1'b1: ns = 1'b0;
		1'b0: if ((key == 1'b1) & (key != FF1Out)) ns = 1'b1;
			  else ns = 1'b0;
		default: ns = 1'b0;
	endcase 
end
	
// clocks user inout b using 2 DFF's
always_ff @(posedge clk) begin
	if (Reset) begin
			FF1Out <= 1'b0;
			out <= 1'b0;
	end
   else begin
			FF1Out <= key;
			out <= ns;
	end
end 
endmodule

module keys_testbench();
 logic clk, Reset, key;
 logic out;

keys dut (clk, Reset, key, out);

parameter CLOCK_PERIOD=100;
initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
											@(posedge clk);
 Reset <= 1;			   			@(posedge clk);
 Reset <= 0; key <= 0;			   @(posedge clk);
											@(posedge clk);
				 key <= 1;				@(posedge clk);
											@(posedge clk);
 Reset <= 1;			   			@(posedge clk);
 Reset <= 0; key <= 0;			   @(posedge clk);
											@(posedge clk);
				 key <= 1;				@(posedge clk);
											@(posedge clk);
$stop; // End the simulation.
 end
endmodule
