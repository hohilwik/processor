module xor_vect_tb;

reg  [63:0] a, b;
reg         c0;
wire [63:0] s;
wire        c64;
reg  [63:0] check;

integer i, j, k;
integer num_correct;
integer num_wrong;

integer tb_file1, tb_file2;

xor_vector xor64(a, b, s);


initial begin
	$display("Running testbench, this will take a few minutes...");
	$dumpfile("xor_vect_tb.vcd");
	$dumpvars;
	num_correct = 0;
	num_wrong = 0;
	
	tb_file1=$fopen("random_64bit_set1.txt", r);
	tb_file2=$fopen("random_64bit_set2.txt", r);
	
	while( !$feof(tb_file1) ) begin
		$fscanf(tb_file1, "%b\n", a);
		$fscanf(tb_file2, "%b\n", b);
		check = a ^ b ;
		#2;
		if( s == check ) begin
			num_correct = num_correct+1;
		end else begin
			num_wrong   = num_wrong + 1;
		end
	end 
	
	$display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);
	
	$fclose(tb_file1);
	$fclose(tb_file2);
	
	$finish;
end

endmodule
