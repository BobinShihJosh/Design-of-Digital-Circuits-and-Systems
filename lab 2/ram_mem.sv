module ram_mem(address, clock, data, wren, q);
	input	logic[4:0] address;
	input	logic clock;
	input logic	[3:0] data;
	input logic wren;
	output logic [3:0] q;
	
	// making memory arrays
	logic [3:0] memory_array [31:0];
	logic [3:0] data_in_reg;
	
	always_ff@(posedge clock) begin
		if (wren) begin
			memory_array[address] <= data;
		end//else 
			//data_in_reg <= memory_array[address];
		q <= memory_array[address];
	end
	
	//assign q = data_in_reg;
			
endmodule 
