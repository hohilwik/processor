`timescale 1ns / 1ps
module GrayCell(
	input Gik,
	input Pik,
	input Gk_1j,
	output Gij
    );

wire net1;

and #0.1 (net1,Pik,Gk_1j);
or #0.1 (Gij,Gik,net1);		// output Gij generated here

endmodule
