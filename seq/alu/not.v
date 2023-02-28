

module not_vector(
	input wire [63:0]a,
	output wire [63:0]out
	);
	
genvar i;

generate for(i=0; i<64; i=i+1)
	begin
		not not_gate1( out[i], a[i] );
	end
	endgenerate

endmodule