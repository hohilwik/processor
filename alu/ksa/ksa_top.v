`default_nettype none

module ksa_top(
  input  wire        c0,
  input  wire [63:0] inp_a,
  input  wire [63:0] inp_b,
  output wire [63:0] out_s,
  output wire        out_carry
);

/*

module ksa_32(
  input  wire        c0,
  input  wire [31:0] i_a,
  input  wire [31:0] i_b,
  output wire [31:0] o_s,
  output wire        o_carry
);

*/

wire c_mid;
//wire c_top;

//assign c_top = c_mid;

ksa_32 lower32(c0, inp_a[31:0], inp_b[31:0], out_s[31:0], c_mid);
ksa_32 upper32(c_mid, inp_a[63:32], inp_b[63:32], out_s[63:32], out_carry);

endmodule





