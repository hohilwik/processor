`timescale 1ns/1ps

`include "/home/hohilwik/Code/processor/alu/ksa/cell_black.v"
`include "/home/hohilwik/Code/processor/alu/ksa/cell_grey.v"
`include "/home/hohilwik/Code/processor/alu/ksa/cell_pg.v"
`include "/home/hohilwik/Code/processor/alu/ksa/ksa_1.v"
`include "/home/hohilwik/Code/processor/alu/ksa/ksa_2.v"
`include "/home/hohilwik/Code/processor/alu/ksa/ksa_3.v"
`include "/home/hohilwik/Code/processor/alu/ksa/ksa_4.v"
`include "/home/hohilwik/Code/processor/alu/ksa/ksa_5.v"
`include "/home/hohilwik/Code/processor/alu/ksa/ksa_6.v"
`include "/home/hohilwik/Code/processor/alu/ksa/ksa_7.v"
`include "/home/hohilwik/Code/processor/alu/ksa/ksa_32.v"
`include "/home/hohilwik/Code/processor/alu/ksa/ksa_top.v"


module addition_tb;

/*reg  [63:0] a, b;
reg         c0;
wire [63:0] s;
wire        c64;
reg  [64:0] check;

integer i, j, k;
integer num_correct;
integer num_wrong;

integer tb_file1, tb_file2;

addition ks64(.c0(c0), .inp_a(a), .inp_b(b), .out_s(s), .out_carry(c64) );
*/

initial begin
	$display("Running testbench, this will take a few minutes...");
	/*$dumpfile("addition_tb.vcd");
	$dumpvars;
	num_correct = 0;
	num_wrong = 0;
	
	tb_file1=$fopen("random_64bit_set1.txt", r);
	tb_file2=$fopen("random_64bit_set2.txt", r);
	
	while( !$feof(tb_file1) ) begin
		$fscanf(tb_file1, "%b\n", a);
		$fscanf(tb_file2, "%b\n", b);
		for(i=0; i<2; i=i+1) begin
			c0 = i;
			check = a + b + c0;
			#2;
			if( {c64, s} == check ) begin
				num_correct = num_correct+1;
			end else begin
				num_wrong   = num_wrong + 1;
			end
		end 
	end 
	
	$display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);
	
	$fclose(tb_file1);
	$fclose(tb_file2);
	
	//$finish;*/
end

endmodule