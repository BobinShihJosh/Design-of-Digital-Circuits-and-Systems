 module countCar (clk, Reset, cen, cex, Czero, Cone, H2, H3, H4, H5);
 input logic clk, Reset;
 input logic cen, cex;
 output logic [6:0] Czero, Cone, H2, H3, H4, H5;
 
 logic [4:0] count; //4 bit counter up to 25
 
// counter that increments a count if count is below 25 and receives clocked enter input, and 
// decrements the count of the count is above 0 and receives a clocked exit input
always_ff @(posedge clk) 
	if (Reset) begin
		count <= 5'b00000;
		end
   else if ((count < 5'b11001) & cen) begin
		count++;
		end
	else if ((count > 5'b00000) & cex) begin
		count--;
	end
	else begin
		count <= count;
	end
 
 // sends the count number to a display module that would display the count on the 7-segment hex display
  display track (.cnt(count), .Czero(Czero), .Cone(Cone), .H2(H2), .H3(H3), .H4(H4), .H5(H5));

endmodule



module countCar_testbench();
 logic clk, Reset;
 logic cen, cex;
 logic [6:0] Czero, Cone, H2, H3, H4, H5;

countCar dut (.clk, .Reset, .cen, .cex, .Czero, .Cone, .H2, .H3, .H4, .H5);

 // Set up the clock.
parameter CLOCK_PERIOD=100;
initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
									 @(posedge clk);
								
	Reset <= 1;					 @(posedge clk);
	
	Reset <= 0;    cen<=0;cex<=0;@(posedge clk); //should display CLEAR0
						cen<=1;cex<=0;@(posedge clk); // 1
						cen<=0;cex<=1;@(posedge clk); // exit a car should be back to CLEAR0
						cen<=0;cex<=1;@(posedge clk); // exit another car when there is already no cars(CLEAR0) so should still remain at CLEAR0
						cen<=1;cex<=0;@(posedge clk); // 1 enter a car
						cen<=1;cex<=0;@(posedge clk); // 2
						cen<=1;cex<=0;@(posedge clk); // 3
						cen<=1;cex<=0;@(posedge clk); // 4 
						cen<=1;cex<=0;@(posedge clk); // 5
						cen<=1;cex<=0;@(posedge clk); // 6
						cen<=1;cex<=0;@(posedge clk); // 7
						cen<=1;cex<=0;@(posedge clk); // 8
						cen<=1;cex<=0;@(posedge clk); // 9
						cen<=1;cex<=0;@(posedge clk); // 10
						cen<=1;cex<=0;@(posedge clk); // 11
						cen<=1;cex<=0;@(posedge clk); // 12
						cen<=1;cex<=0;@(posedge clk); // 13
						cen<=1;cex<=0;@(posedge clk); // 14
						cen<=1;cex<=0;@(posedge clk); // 15 
						cen<=1;cex<=0;@(posedge clk); // 16
						cen<=1;cex<=0;@(posedge clk); // 17
						cen<=1;cex<=0;@(posedge clk); // 18
						cen<=1;cex<=0;@(posedge clk); // 19
						cen<=1;cex<=0;@(posedge clk); // 20
						cen<=1;cex<=0;@(posedge clk); // 21
						cen<=1;cex<=0;@(posedge clk); // 22
						cen<=1;cex<=0;@(posedge clk); // 23
						cen<=1;cex<=0;@(posedge clk); // 24
						cen<=1;cex<=0;@(posedge clk); // should display FULL25
						cen<=1;cex<=0;@(posedge clk); // test enter one more car it should still display FULL25
						cen<=0;cex<=1;@(posedge clk); // 24
						cen<=0;cex<=1;@(posedge clk); // 23
						cen<=0;cex<=1;@(posedge clk); // 22
						
																																													
																																																											 
						 
$stop; // End the simulation.
 end
 endmodule
 