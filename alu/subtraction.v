//`include "/home/hohilwik/Code/assignment-1-alu-miss-47/alu/addition.v"
//`include "not.v"

module subtract(
	input  wire   [63:0]a,
	input  wire   [63:0]b,
	output wire   [63:0]out,
	output wire         flag
	);
	
 wire [63:0]binvert;
 wire [63:0]ones;
 wire [63:0]bcomp;
 wire       in_carry;
 wire       c_out;
 
 assign ones=64'b1;
 assign in_carry='0;
 not_vector n1(b, binvert);
 
 addition comp_gen  (in_carry, binvert, ones, bcomp, c_out);
 
 addition sub_result(in_carry, a, bcomp, out, flag);
 
endmodule
 