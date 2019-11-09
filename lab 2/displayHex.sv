module displayHex (in, display);
	input logic [3:0] in;
	output logic [6:0] display;
	
	always_comb begin
		case(in)
			4'h0: display = 7'b1000000;
			4'h1: display = 7'b1111001;
			4'h2: display = 7'b0100100;
			4'h3: display = 7'b0110000;
			4'h4: display = 7'b0011001;
			4'h5: display = 7'b0010010;
			4'h6: display = 7'b0000010;
			4'h7: display = 7'b1111000;
			4'h8: display = 7'b0000000;
			4'h9: display = 7'b0011000;
			4'hA: display = 7'b0001000;
			4'hB: display = 7'b0000011;
			4'hC: display = 7'b1000110;
			4'hD: display = 7'b0100001;
			4'hE: display = 7'b0000110;
			4'hF: display = 7'b0001110;
			default : display = 7'bx;
		endcase
	end
endmodule

module displayHex_testbench();
	logic [3:0] in;
	logic [6:0] display;
	
	displayHex dut(in, display);
	
	parameter delay = 10;
	
	initial begin
		in=4'b0000; #delay; 
		in=4'b0001; #delay; 
		in=4'b0010; #delay;
		in=4'b0011; #delay;
		in=4'b0100; #delay;
		in=4'b0101; #delay;
		in=4'b0110; #delay;
		in=4'b0111; #delay;
		in=4'b1000; #delay;
		in=4'b1001; #delay;
		in=4'b1010; #delay;
		in=4'b1011; #delay;
		in=4'b1100; #delay;
		in=4'b1101; #delay;
		in=4'b1110; #delay;
		in=4'b1111; #delay;
		
	end
	
	
endmodule
