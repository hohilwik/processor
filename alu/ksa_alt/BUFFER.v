`timescale 1ns / 1ps
module BUFFER(
	input Pi,
	input Gi,
	output Po,
	output Go
    );
	 
assign #0.1 Po = Pi;
assign #0.1 Go = Gi;

endmodule
