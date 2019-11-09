module display(cnt, Czero, Cone, H2, H3, H4, H5);
	input logic [4:0] cnt;
	output logic [6:0] Czero, Cone, H2, H3, H4, H5;
	
	// map the count passed in onto the actual 7segment hex display for each count
	always_comb begin
		case(cnt) 
			5'b00000: begin Czero = 7'b1000000; Cone = 7'b0001000; H2 = 7'b0001000; H3 = 7'b0000110; H4 = 7'b1000111; H5 = 7'b1000110; end //CLEAR0
			5'b00001: begin Czero = 7'b1111001; Cone = 7'b1111111; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111; end
			5'b00010: begin Czero = 7'b0100100; Cone = 7'b1111111; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b00011: begin Czero = 7'b0110000; Cone = 7'b1111111; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b00100: begin Czero = 7'b0011001; Cone = 7'b1111111; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b00101: begin Czero = 7'b0010010; Cone = 7'b1111111; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b00110: begin Czero = 7'b0000010; Cone = 7'b1111111; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b00111: begin Czero = 7'b1111000; Cone = 7'b1111111; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b01000: begin Czero = 7'b0000000; Cone = 7'b1111111; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b01001: begin Czero = 7'b0010000; Cone = 7'b1111111; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b01010: begin Czero = 7'b1000000; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b01011: begin Czero = 7'b1111001; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b01100: begin Czero = 7'b0100100; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b01101: begin Czero = 7'b0110000; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b01110: begin Czero = 7'b0011001; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b01111: begin Czero = 7'b0010010; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b10000: begin Czero = 7'b0000010; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b10001: begin Czero = 7'b1111000; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b10010: begin Czero = 7'b0000000; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b10011: begin Czero = 7'b0010000; Cone = 7'b1111001; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b10100: begin Czero = 7'b1000000; Cone = 7'b0100100; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b10101: begin Czero = 7'b1111001; Cone = 7'b0100100; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b10110: begin Czero = 7'b0100100; Cone = 7'b0100100; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b10111: begin Czero = 7'b0110000; Cone = 7'b0100100; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b11000: begin Czero = 7'b0011001; Cone = 7'b0100100; H2 = 7'b1111111; H3 = 7'b1111111; H4 = 7'b1111111; H5 = 7'b1111111;end
			5'b11001: begin Czero = 7'b0010010; Cone = 7'b0100100; H2 = 7'b1000111; H3 = 7'b1000111; H4 = 7'b1000001; H5 = 7'b0001110;end //FULL25

			

			default: begin Czero = 7'b1000000; Cone = 7'b0001000; H2 = 7'b0001000; H3 = 7'b0110000; H4 = 7'b1110001; H5 = 7'b0110001; end

		endcase
	end
endmodule 

