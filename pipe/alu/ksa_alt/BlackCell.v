`timescale 1ns / 1ps
module BlackCell(
	input Gik,
	input Pik,
	input Gk_1j,
	input Pk_1j,
	output Gij,
	output Pij
    );
	 
wire net1;

and #0.1 (net1,Pik,Gk_1j);
or #0.1 (Gij,Gik,net1);		// output Gij generated here

and #0.1 (Pij,Pik,Pk_1j);		// output Pij generated

endmodule
