`timescale 1ns / 1ps
module SumGen(
		input ci_1,
		input Pii,
		output Sum
    );

xor #0.1 (Sum,ci_1,Pii);

endmodule
