// Given 5 bit number decode into hexadecimal in 2 7seg hex displays 
module HexDisplay(addr, Czero, Cone);
	input logic [4:0] addr;
	output logic [6:0] Czero, Cone;
	
	always_comb begin 
		case (addr) 
			5'h0: begin Czero = 7'b1000000; Cone = 7'b1111111; end
			5'h1: begin Czero = 7'b1111001; Cone = 7'b1111111; end
			5'h2: begin Czero = 7'b0100100; Cone = 7'b1111111; end 
			5'h3: begin Czero = 7'b0110000; Cone = 7'b1111111; end
			5'h4: begin Czero = 7'b0011001; Cone = 7'b1111111; end
			5'h5: begin Czero = 7'b0010010; Cone = 7'b1111111; end
			5'h6: begin Czero = 7'b0000010; Cone = 7'b1111111; end
			5'h7: begin Czero = 7'b1111000; Cone = 7'b1111111; end
			5'h8: begin Czero = 7'b0000000; Cone = 7'b1111111; end
			5'h9: begin Czero = 7'b0011000; Cone = 7'b1111111; end
			5'hA: begin Czero = 7'b0001000; Cone = 7'b1111111; end
			5'hB: begin Czero = 7'b0000011; Cone = 7'b1111111; end
			5'hC: begin Czero = 7'b1000110; Cone = 7'b1111111; end
			5'hD: begin Czero = 7'b0100001; Cone = 7'b1111111; end
			5'hE: begin Czero = 7'b0000110; Cone = 7'b1111111; end
			5'hF: begin Czero = 7'b0001110; Cone = 7'b1111111; end
			
			5'h10: begin Czero = 7'b1000000; Cone = 7'b1111001; end
			5'h11: begin Czero = 7'b1111001; Cone = 7'b1111001; end
			5'h12: begin Czero = 7'b0100100; Cone = 7'b1111001; end 
			5'h13: begin Czero = 7'b0110000; Cone = 7'b1111001; end
			5'h14: begin Czero = 7'b0011001; Cone = 7'b1111001; end
			5'h15: begin Czero = 7'b0010010; Cone = 7'b1111001; end
			5'h16: begin Czero = 7'b0000010; Cone = 7'b1111001; end
			5'h17: begin Czero = 7'b1111000; Cone = 7'b1111001; end
			5'h18: begin Czero = 7'b0000000; Cone = 7'b1111001; end
			5'h19: begin Czero = 7'b0011000; Cone = 7'b1111001; end
			5'h1A: begin Czero = 7'b0001000; Cone = 7'b1111001; end
			5'h1B: begin Czero = 7'b0000011; Cone = 7'b1111001; end
			5'h1C: begin Czero = 7'b1000110; Cone = 7'b1111001; end
			5'h1D: begin Czero = 7'b0100001; Cone = 7'b1111001; end
			5'h1E: begin Czero = 7'b0000110; Cone = 7'b1111001; end
			5'h1F: begin Czero = 7'b0001110; Cone = 7'b1111001; end
			
			default : begin Czero = 7'bx; Cone = 7'bx; end
		endcase
	end
endmodule

