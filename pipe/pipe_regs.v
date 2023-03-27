`timescale 1ns/1ps

module regF(
	clk,
	PC_pred,
	f_PC_pred

);

input clk;
input [63:0] PC_pred;
output reg [63:0] f_PC_pred;

always@(posedge clk)
begin
	// assign val to fPCpred
	f_PC_pred <= PC_pred;
end
	

endmodule // reg between PC_pred and fetch

// next module

module regD(
	clk,
	f_status, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP,
	d_status, d_icode, d_ifun, d_rA, d_rB, d_valC, d_valP

);

input clk;
input [2:0] f_status;
input [3:0] f_icode;
input [3:0] f_ifun;
input [3:0] f_rA;
input [3:0] f_rB;
input [63:0] f_valC;
input [63:0] f_valP;

output reg [2:0] d_status;
output reg [3:0] d_icode;
output reg [3:0] d_ifun;
output reg [3:0] d_rA;
output reg [3:0] d_rB;
output reg [63:0] d_valC;
output reg [63:0] d_valP;

always@(posedge clk)
begin
	d_status <= f_status;
	d_icode <= f_icode;
	d_ifun <= f_ifun;
	d_rA <= f_rA;
	d_rB <= f_rB;
	d_valC <= f_valC;
	d_valP <= f_valP;
end

endmodule // reg between fetch and decode


// next module

module regE(
	clk,
	d_status, d_icode, d_ifun, d_rA, d_rB, d_valC, d_valP, d_valA, d_valB,
	e_status, e_icode, e_ifun, e_rA, e_rB, e_valC, e_valP, e_valA, e_valB

);

input clk;
input [2:0] d_status;
input [3:0] d_icode;
input [3:0] d_ifun;
input [3:0] d_rA;
input [3:0] d_rB;
input [63:0] d_valC;
input [63:0] d_valP;
input [63:0] d_valA;
input [63:0] d_valB;

output reg [2:0] e_status;
output reg [3:0] e_icode;
output reg [3:0] e_ifun;
output reg [3:0] e_rA;
output reg [3:0] e_rB;
output reg [63:0] e_valC;
output reg [63:0] e_valP;
output reg [63:0] e_valA;
output reg [63:0] e_valB;


always@(posedge clk)
begin
	e_status <= d_status;
	e_icode <= d_icode;
	e_ifun <= d_ifun;
	e_rA <= d_rA;
	e_rB <= d_rB;
	e_valC <= d_valC;
	e_valP <= d_valP;
	e_valA <= d_valA;
	e_valB <= d_valB;
end


endmodule // reg between decode and execute



// next module

module regM(
	clk,
	e_status, e_icode, e_rA, e_rB, e_valC, e_valP, e_valA, e_valB, e_cnd, e_valE,
	m_status, m_icode, m_rA, m_rB, m_valC, m_valP, m_valA, m_valB, m_cnd, m_valE

);

input clk;
input [2:0] e_status;
input [3:0] e_icode;
input e_cnd;
input [3:0] e_rA;
input [3:0] e_rB;
input [63:0] e_valA;
input [63:0] e_valB;
input [63:0] e_valC;
input [63:0] e_valP;
input [63:0] e_valE;

output reg [2:0] m_status;
output reg [3:0] m_icode;
output reg m_cnd;
output reg [3:0] m_rA;
output reg [3:0] m_rB;
output reg [63:0] m_valA;
output reg [63:0] m_valB;
output reg [63:0] m_valC;
output reg [63:0] m_valP;
output reg [63:0] m_valE;

always@(posedge clk)
begin
	m_status <= e_status;
	m_icode <= e_icode;
	m_cnd <= e_cnd;
	m_rA <= e_rA;
	m_rB <= e_rB;
	m_valC <= e_valC;
	m_valP <= e_valP;
	m_valA <= e_valA;
	m_valB <= e_valB;
	m_valE <= e_valE;
end


endmodule // reg between execute and memory


// next module

module regW(
	clk,
	m_status, m_icode, m_rA, m_rB, m_valC, m_valP, m_valA, m_valB, m_cnd, m_valE, m_valM,
	w_status, w_icode, w_rA, w_rB, w_valC, w_valP, w_valA, w_valB, w_cnd, w_valE, w_valM

);

input clk;
input [2:0] m_status;
input [3:0] m_icode;
input m_cnd;
input [3:0] m_rA;
input [3:0] m_rB;
input [63:0] m_valA;
input [63:0] m_valB;
input [63:0] m_valC;
input [63:0] m_valP;
input [63:0] m_valE;
input [63:0] m_valM;

output reg [2:0] w_status;
output reg [3:0] w_icode;
output reg w_cnd;
output reg [3:0] w_rA;
output reg [3:0] w_rB;
output reg [63:0] w_valA;
output reg [63:0] w_valB;
output reg [63:0] w_valC;
output reg [63:0] w_valP;
output reg [63:0] w_valE;
output reg [63:0] w_valM;


always@(posedge clk)
begin
	w_status <= m_status;
	w_icode <= m_icode;
	w_cnd <= m_cnd;
	w_rA <= m_rA;
	w_rB <= m_rB;
	w_valC <= m_valC;
	w_valP <= m_valP;
	w_valA <= m_valA;
	w_valB <= m_valB;
	w_valE <= m_valE;
	w_valM <= m_valM;
end


endmodule // reg between memory and write_back