`timescale 1ns/1ps

module regF(

	input wire clk,
	input wire [63:0] PC_pred,
	

);

endmodule // reg between PC_pred and fetch

module regD(

);

endmodule // reg between fetch and decode

module regE(

);

endmodule // reg between decode and execute

module regM(

);

endmodule // reg between execute and memory

module regW(

);

endmodule // reg between memory and write_back