`timescale 1ns / 1ps


module KoggeStone32Bit_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg Cin;

	// Outputs
	wire [31:0] S;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	KoggeStone32Bit uut (
		.A(A), 
		.B(B), 
		.Cin(Cin), 
		.S(S), 
		.Cout(Cout)
	);

	initial begin
		
		$display("Running testbench, this will take a few minutes...");
		$dumpfile("addition_tb.vcd");
		$dumpvars;
	

		// Initialize Inputs
		A = 0;
		B = 0;
		Cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		A = 32'hFFFF0000;
		B = 32'h0000FFFF;
		Cin = 1;
		
		#300;
		A = 32'd2017701177;
		B = 32'd1701853;
		Cin = 0;
		
		#300;
		A = 32'hFFABCEDC;
		B = 32'hEF821EDA;
		Cin = 1;


	end
      
endmodule

