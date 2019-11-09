module dataPath (clk, lookDown, lookUp, rst, din_ram, A_addr, currA);
	input logic clk, lookDown, lookUp, rst;
	input logic [7:0] din_ram;
	
	// output current address and data 
	output logic [4:0] A_addr;
	output logic [7:0] currA;
	
	// Bounds for binary search implementation
	logic [4:0] HIGH, LOW, MID;
	
	// essential logic to implement binary search
	assign MID = ((HIGH + LOW) / 2);
	assign currA = din_ram;
	assign A_addr = MID;
	
	// implementing binary search algorithm here
	always_ff @(posedge clk) begin
		if (rst) begin
			LOW <= 5'b00000;
			HIGH <= 5'b11111;
		end 
		if (lookUp) begin
			LOW <= MID + 1'b1;
		end
		if (lookDown) begin
			HIGH <= MID - 1'b1;
		end 
	end
endmodule 