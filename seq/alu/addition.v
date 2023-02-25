`timescale 1ns/1ps

//`include "./ksa_final/black.v"
//`include "./ksa_final/grey.v"
//`include "./ksa_final/pg.v"
//`include "./ksa_final/ks_1.v"
//`include "./ksa_final/ks_2.v"
//`include "./ksa_final/ks_3.v"
//`include "./ksa_final/ks_4.v"
//`include "./ksa_final/ks_5.v"
//`include "./ksa_final/ks_6.v"
//`include "./ksa_final/ks_7.v"
//`include "./ksa_final/ksa_top.v"


module addition(
  input  wire        c0,
  input  wire [63:0] inp_a,
  input  wire [63:0] inp_b,
  output wire [63:0] out_s,
  output wire        out_carry
);

/*

wire c_mid;
ksa_32 lower32(c0, inp_a[31:0], inp_b[31:0], out_s[31:0], c_mid);
ksa_32 upper32(c_mid, inp_a[63:32], inp_b[63:32], out_s[63:32], out_carry);


*/

wire c_mid;
ksa_top lower32(c0,    inp_a[31:0],  inp_b[31:0],  out_s[31:0], c_mid);
ksa_top upper32(c_mid, inp_a[63:32], inp_b[63:32], out_s[63:32], out_carry);

endmodule