`timescale 1ns/1ps

`include "/mnt/c/Users/shant/Desktop/Data/Code/processor/seq/alu/ksa_alt/KoggeStone32Bit.v";

module addition_alt_tb;

/*
reg  [63:0] a, b;
reg         c0;
wire [63:0] s;
wire        c64;
reg  [63:0] check;
*/

//alt init

reg [31:0] A, B;
reg Cin;
wire [31:0] S;
wire Cout;
reg [31:0] check;

//alt init end

//integer a_temp, b_temp;

integer i, j, k;
integer num_correct;
integer num_wrong;

integer tb_file1, tb_file2;
integer scan1, scan2;

//addition_alt ks64(.c0(c0), .inp_a(a), .inp_b(b), .out_s(s), .out_carry(c64) );
KoggeStone32Bit ks32(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout) );


initial begin
	$display("Running testbench, this will take a few minutes...");
	$dumpfile("addition_tb.vcd");
	$dumpvars;
	num_correct = 0;
	num_wrong = 0;
	
	//alt start

	for(i=0; i<16; i=i+1) begin
		A=i;
		for(j=0; j<16; j=j+1) begin
			B=j;
			for(k=0; k<2; k=k+1) begin
				Cin=k;
				check = A+B+Cin;
				#2;

				if( (S+Cout)== check ) begin
					num_correct = num_correct + 1;
				end else begin
					num_wrong = num_wrong + 1;
					$display("check=%d, sum=%d, diff=%d, Cout=%d, Cin=%d", check, S, check-S, Cout, Cin);
				end
			end
		end
	end


	//alt end

	/*tb_file1=$fopen("random_64bit_set1.txt", "r");
	tb_file2=$fopen("random_64bit_set2.txt", "r");
	
	for(j=0; j<5; j=j+1) begin
		scan1 = $fscanf(tb_file1, "%b\n", a);
		scan2 = $fscanf(tb_file2, "%b\n", b);

		#2;
		$display("A_read= %b, B_read= %b, check= %b, s= %b", a, b, check, s);


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
	*/
	$display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);
	
	$fclose(tb_file1);
	$fclose(tb_file2);
	
	$finish;
end

endmodule