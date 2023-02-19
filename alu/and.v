

module and_vector(
	input wire [63:0]a,
	input wire [63:0]b,
	output wire [63:0]out
	);
	
genvar i;

generate for(i=0; i<64; i=i+1)
	begin
		and and_gate1( out[i], a[i], b[i] );
	end
	endgenerate

endmodule