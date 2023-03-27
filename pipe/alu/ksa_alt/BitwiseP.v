`timescale 1ns / 1ps
module BitwiseP(
		input Ai,
		input Bi,
		output Pi
    );

xor #0.1 (Pi,Ai,Bi);

endmodule
