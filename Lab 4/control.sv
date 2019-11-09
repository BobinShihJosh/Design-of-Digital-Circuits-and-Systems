module control (clk, reset, start, A, currA, FOUND, lookDown, lookUp, rst);
	input logic clk, reset, start;
	input logic [7:0] A, currA;
	
	//output control signals to datapath
	output logic FOUND, lookDown, lookUp, rst;
	
	/*
		s_1 is idle stage
		s_2 is found A in ram stage
		s_3 is done stage
	*/
	enum logic [1:0] {s_1=2'b00, s_2=2'b01, s_3} ps, ns;
	
	logic found;
	
	// finite state machine 
	always_comb begin
		case (ps) 
			s_1: if (start) begin
				     ns = s_2;
				  end else begin
				     ns = s_1;
				  end
			s_2: if (found) begin
					  ns = s_3;
				  end else begin
				     ns = s_2;
				  end
			s_3: if (start) begin
				     ns = s_3;
				  end else begin
				     ns = s_1;
				  end
		endcase
	end
	
	// assign control output signals depending on A is found or not
	assign FOUND = (ps == s_3); 
	assign found = (A == currA);
	assign lookDown = (~found) && (A < currA) && (ps == s_2);
	assign lookUp = (~found) && (A > currA) && (ps == s_2); 
	assign rst = (ps == s_1);
	
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= s_1;
		end else begin
			ps <= ns;
		end
	end

endmodule

module control_testbench();


endmodule

