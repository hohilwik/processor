`default_nettype none

`include "/home/hohilwik/Code/processor/alu/and.v"
`include "/home/hohilwik/Code/processor/alu/addition.v"
`include"/home/hohilwik/Code/processor/alu/ksa_final/black.v"
`include"/home/hohilwik/Code/processor/alu/ksa_final/grey.v"
`include"/home/hohilwik/Code/processor/alu/ksa_final/pg.v"
`include "/home/hohilwik/Code/processor/alu/ksa_final/ks_1.v"
`include "/home/hohilwik/Code/processor/alu/ksa_final/ks_2.v"
`include "/home/hohilwik/Code/processor/alu/ksa_final/ks_3.v"
`include "/home/hohilwik/Code/processor/alu/ksa_final/ks_4.v"
`include "/home/hohilwik/Code/processor/alu/ksa_final/ks_5.v"
`include "/home/hohilwik/Code/processor/alu/ksa_final/ks_6.v"
`include "/home/hohilwik/Code/processor/alu/ksa_final/ks_7.v"
`include "/home/hohilwik/Code/processor/alu/ksa_final/ksa_top.v"
`include "/home/hohilwik/Code/processor/alu/subtraction.v"
`include "/home/hohilwik/Code/processor/alu/xor.v"
`include "/home/hohilwik/Code/processor/alu/not.v"



module alu(
	input wire   [1:0]operation,
	input wire  [63:0]a,
	input wire  [63:0]b,
	output wire  [63:0]out,
	output wire       flag
	);
	
// 0 adder
// 1 subtract
// 2 and
// 3 xor

	wire [63:0]op_adder;
	wire [63:0]op_sub;
	wire [63:0]op_andvec;
	wire [63:0]op_xorvec;

	wire [63:0]adder_out;
	wire [63:0]sub_out;
	wire [63:0]andvec_out;
	wire [63:0]xorvec_out;

	wire flag_adder;
	wire flag_sub;
	
	output reg  [63:0]result;
	output reg       flaggy;
	input wire       in_flag;
	
	assign in_flag = 1'b0;
	
	
	addition	add_alu		( in_flag, a, b, adder_out, flag_adder);
	subtract 	sub_alu		(          a, b, sub_out, flag_sub);
	and_vector  andvec_alu	(          a, b, andvec_out);
	xor_vector  xorvec_alu  (          a, b, xorvec_out);
	
	
	always @(*)
	begin
		case(operation)
			2'b00:begin
				result  = adder_out;
				flaggy  = flag_adder;
			end
			
			2'b01:begin
				result  = sub_out;
				flaggy  = flag_sub;
			end
			
			2'b10:begin
				result = andvec_out;
				flaggy = in_flag;
			end
				
			2'b11:begin
				result = xorvec_out;
				flaggy = in_flag;
			end
		endcase
	end
	
	assign out  = result;
	assign flag = flaggy;
	
endmodule
