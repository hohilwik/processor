`timescale 1ns/1ps

`include "./ksa_alt/KoggeStone32Bit.v"

module addition_alt(
  input          c0,
  input   [63:0] inp_a,
  input   [63:0] inp_b,
  output  [63:0] out_s,
  output         out_carry
);

//ksa_alt_top adder(c0, inp_a, inp_b, out_s, out_carry);

/*

module KoggeStone32Bit(
		input [31:0] A,
		input [31:0] B,
		input Cin,
		output [31:0] S,
		output Cout
);


wire c_mid;
ksa_32 lower32(c0, inp_a[31:0], inp_b[31:0], out_s[31:0], c_mid);
ksa_32 upper32(c_mid, inp_a[63:32], inp_b[63:32], out_s[63:32], out_carry);


*/

wire c_mid;

KoggeStone32Bit lower32(inp_a[31:0], inp_b[31:0], c0, out_s[31:0], c_mid);
KoggeStone32Bit upper32(inp_a[63:32], inp_b[63:32], c_mid, out_s[63:32], out_carry);

endmodule