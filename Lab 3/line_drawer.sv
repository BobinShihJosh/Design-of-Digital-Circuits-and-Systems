
module line_drawer(
	input logic clk, reset,
	input logic [10:0]	x0, y0, x1, y1, //the end points of the line
	output logic [10:0]	x, y //outputs corresponding to the pair (x, y)
	);
	
	
	logic signed [11:0] error, y_error, tmp_err;
	// 
	logic [10:0] x0_stp, x1_stp, y0_stp, y1_stp;
	logic [10:0] x0_fix, x1_fix, y0_fix, y1_fix;
	
	logic [10:0] width, height;
	
	logic [10:0] delta_x, delta_y;
	
	logic step;
	assign step = 1'b1;
	logic step_down;
	
	logic is_stp;
	logic is_inv;
	
	//See if line is steep and see if line is drawn from right to left
	always_comb begin
		width = (x1 > x0)? (x1 - x0) : (x0 - x1);
		height = (y1 > y0)? (y1 - x0) : (y0 - y1);
		
		is_stp = (height > width)? 1'b1 : 1'b0;
	end
	
	/*
	Unify coordinate system for drawing line later by switching x0, x1, y0, y1 around for
	cases when the line is steep or/and when the line is drawn from right to left instead 
	of from left to right.
	*/
	always_comb begin 
		/*
		first, switch x0, x1, y0, y1 accordingly if line is steep
		*/
		if (is_stp) begin
			x0_stp = y0;
			x1_stp = y1;
			y0_stp = x0;
			y1_stp = x1;
		end else begin
			x0_stp = x0;
			x1_stp = x1;
			y0_stp = y0;
			y1_stp = y1;
		end
		
		/* 
		Second, switch x0_stp, x1_stp, y0_stp, y1_stp accordingly if line is drawn from right to left 
		instead of from right to left
		*/
		if (x0_stp > x1_stp) begin
			x0_fix = x1_stp;
			x1_fix = x0_stp;
			y0_fix = y1_stp;
			y1_fix = y0_stp;
		end else begin
			x0_fix = x0_stp;
			x1_fix = x1_stp;
			y0_fix = y0_stp;
			y1_fix = y1_stp;
		end
	end
	
	/* 
		
	*/
	always_comb begin
		delta_x = (x1_fix > x0_fix)? (x1_fix - x0_fix) : (x1_fix - x0_fix); 
		delta_y = (y1_fix > y0_fix)? (y1_fix - y0_fix) : (y0_fix - y1_fix); 
		step_down = (y0_fix < y1_fix)? 1:0;

		y_error = error + delta_y; // updates error
	end
	
	// implementation of bresenham's line algorithm
	always_ff @(posedge clk) begin
		if (reset) begin
			// draw pixels at x0 and y0
			if (~is_stp) begin
				x <= x0_fix;
				y <= y0_fix;
			end else begin
				x <= y0_fix;
				y <= x0_fix;
			end
			error <= -(delta_x / (2'b10)); // Intial error value
		end else begin
			if (~is_stp) begin
				if (x == x1_fix) begin //When finish drawing the line
					error <= error;
					x <= x;
					y <= y;
				end else begin // progress of drawing the line
					error <= y_error; //updates error to see if it should draw in y direction
					x <= x + 1;
					if (error >= 0) begin 
						if (step_down) begin //see which direction y is stepping into
							y <= y + step; 
						end else begin
							y <= y - step;
						end
						error <= y_error - delta_x; 
					end else begin
						y <= y;
					end
				end
			end else begin 
				if (y == x1_fix) begin //When finish drawing the line
					error <= error;
					x <= x;
					y <= y;
				end else begin // progress of drawing the line
					error <= y_error; //updates error to see if it should draw in x direction
					y <= y + 1;
					if (error >= 0) begin 
						if (step_down) begin //see which direction x is stepping into
							x <= x + step; 
						end else begin
							x <= x - step;
						end
						error <= y_error - delta_x; 
					end else begin
						x <= x;
					end
				end
			end
		end	
	end     
endmodule

// testbench
module line_drawer_testbench();
	logic clk, reset;
	logic [10:0] x0, x1, y0, y1, x, y;
	
	line_drawer dut (clk, reset, x0, y0, x1, y1, x, y);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk<= ~clk;
	end
	
	integer i;
	initial begin
		reset <= 1;														@(posedge clk);		
																			@(posedge clk);					
						x0 <= 200; x1 <= 250; y0 <= 200; y1 <= 100;		@(posedge clk);
																			@(posedge clk);
																			@(posedge clk);
		reset <= 0;														@(posedge clk);	
																		for (i = 0; i<500; i++) begin
																			@(posedge clk);
																		end			
		$stop;
	end
	
endmodule 
