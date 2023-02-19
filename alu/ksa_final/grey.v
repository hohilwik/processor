`default_nettype none

module grey(
  input  wire i_gj,
  input  wire i_pk,
  input  wire i_gk,
  output wire o_g
);

assign o_g = i_gk | (i_gj & i_pk);

// wire temp1;
// and and_gate1(temp1, i_gj, i_pk);
// or or_gate1(o_g, temp1, i_gk);

endmodule
