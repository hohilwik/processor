`timescale 1ns / 1ps

`include "pipe_regs.v"
`include "1_fetch.v"
`include "2_decode.v"
`include "3_execute.v"
`include "4_memory.v"
`include "5_write_back.v"
`include "6_pc_update.v"

module proc;
	reg clk;
	reg [63:0] PC;
	reg status[2:0];
	
	wire [63:0] updated_PC;
	wire [63:0] f_PC_pred;
	wire [63:0] readback;
	wire [2:0] f_status;
	wire [3:0] f_icode;
	wire [3:0] f_ifun;
	wire [3:0] f_rA;
	wire [3:0] f_rB;
	wire [63:0] f_valC;
	wire [63:0] f_valP;
	wire [2:0] d_status;
	wire [3:0] d_icode;
	wire [3:0] d_ifun;
	wire [3:0] d_rA;
	wire [3:0] d_rB;
	wire [63:0] d_valC;
	wire [63:0] d_valP;
	wire [63:0] d_valA;
	wire [63:0] d_valB;
	wire [63:0] d_valE;
	wire [63:0] d_valM;
	
	wire [2:0] e_status;
	wire [3:0] e_icode;
	wire [3:0] e_ifun;
	wire e_cnd;
	wire [3:0] e_rA;
	wire [3:0] e_rB;
	wire [63:0] e_valA;
	wire [63:0] e_valB;
	wire [63:0] e_valC;	
	wire [63:0] e_valP;
	wire [63:0] e_valE;

	wire [2:0] m_status;
	wire [3:0] m_icode;
	wire m_cnd;
	wire [3:0] m_rA;
	wire [3:0] m_rB;
	wire [63:0] m_valA;
	wire [63:0] m_valB;
	wire [63:0] m_valC;
	wire [63:0] m_valP;
	wire [63:0] m_valE;
	wire [63:0] m_valM;
	
	wire [2:0] w_status;
	wire [3:0] w_icode;
	wire w_cnd;
	wire [3:0] w_rA;
	wire [3:0] w_rB;
	wire [63:0] w_valA;
	wire [63:0] w_valB;
	wire [63:0] w_valC;
	wire [63:0] w_valP;
	wire [63:0] w_valE;
	wire [63:0] w_valM;
	
	wire instr_validity;
	wire imem_error;
	wire cnd;
	wire hltins;
	wire vflag;
	
	wire [63:0] reg_mem0;
	wire [63:0] reg_mem1;
	wire [63:0] reg_mem2;
	wire [63:0] reg_mem3;
	wire [63:0] reg_mem4;
	wire [63:0] reg_mem5;
	wire [63:0] reg_mem6;
	wire [63:0] reg_mem7;
	wire [63:0] reg_mem8;
	wire [63:0] reg_mem9;
	wire [63:0] reg_mem10;
	wire [63:0] reg_mem11;
	wire [63:0] reg_mem12;
	wire [63:0] reg_mem13;
	wire [63:0] reg_mem14;
	
	wire sflag;
	wire zflag;
	wire oflag;
	
	reg [7:0] proc_mem[0:4095];
	
fetch_ins fetch1(
	.clk(clk),
	.PC(PC),
	.icode(f_icode),
	.ifun(f_ifun),
	.rA(f_rA),
	.rB(f_rB),
	.valC(f_valC),
	.valP(f_valP),
	.instr_validity(instr_validity),
	.imem_error(imem_error),
	.hlt(hltins) 
	, .proc_mem(proc_mem)
	);
	


decode_ins decode1(
	.clk(clk),
	.cnd(cnd),
	.icode(d_icode),
	.rA(d_rA),
	.rB(d_rB),
	.valA(d_valA),
	.valB(d_valB),
	.valE(d_valE),
	.valM(d_valM),
	.vflag(vflag),
	.reg_mem0(reg_mem0),
    .reg_mem1(reg_mem1),
    .reg_mem2(reg_mem2),
    .reg_mem3(reg_mem3),
    .reg_mem4(reg_mem4),
    .reg_mem5(reg_mem5),
    .reg_mem6(reg_mem6),
    .reg_mem7(reg_mem7),
    .reg_mem8(reg_mem8),
    .reg_mem9(reg_mem9),
    .reg_mem10(reg_mem10),
    .reg_mem11(reg_mem11),
    .reg_mem12(reg_mem12),
    .reg_mem13(reg_mem13),
    .reg_mem14(reg_mem14)
	);

execute_ins execute1(
	.clk(clk),
	.icode(e_icode),
	.ifun(e_ifun),
	.vflag(vflag),
	.valA(e_valA),
	.valB(e_valB),
	.valC(e_valC),
	.valE(e_valE),
	.cnd(e_cnd),
	.zflag(zflag),
	.sflag(sflag),
	.oflag(oflag)
	
	);

memory memory1(
	.clk(clk),
	.icode(m_icode),
	.valA(m_valA),
	.valB(m_valB),
	.valE(m_valE),
	.valP(m_valP),
	.valM(m_valM),
	.readback(readback)
	//, .proc_mem(proc_mem)
	);

write_back wb1(
	.clk(clk),
	.cnd(w_cnd),
	.icode(w_icode),
	.rA(w_rA),
	.rB(w_rB),
	.valA(w_valA),
	.valB(w_valB),
	.valE(w_valE),
	.valM(w_valM),
	.reg_mem0(reg_mem0),
    .reg_mem1(reg_mem1),
    .reg_mem2(reg_mem2),
    .reg_mem3(reg_mem3),
    .reg_mem4(reg_mem4),
    .reg_mem5(reg_mem5),
    .reg_mem6(reg_mem6),
    .reg_mem7(reg_mem7),
    .reg_mem8(reg_mem8),
    .reg_mem9(reg_mem9),
    .reg_mem10(reg_mem10),
    .reg_mem11(reg_mem11),
    .reg_mem12(reg_mem12),
    .reg_mem13(reg_mem13),
    .reg_mem14(reg_mem14)
	);

pc_update pc_update1(
	.clk(clk),
	.cnd(w_cnd),
	.PC(PC),
	.icode(w_icode),
	.valC(w_valC),
	.valP(f_PC_pred),
	.valM(w_valM),
	.updated_PC(updated_PC)
	);
	
regF regF1(
	.clk(clk),
	.PC_pred(f_valP),
	.f_PC_pred(f_PC_pred)
);

regD regD1(
	.clk(clk),
	.f_status(f_status),
	.f_icode(f_icode),
	.f_ifun(f_ifun),
	.f_rA(f_rA),
	.f_rB(f_rB),
	.f_valC(f_valC),
	.f_valP(f_valP),
	.d_status(d_status),
	.d_icode(d_icode),
	.d_ifun(d_ifun),
	.d_rA(d_rA),
	.d_rB(d_rB),
	.d_valC(d_valC),
	.d_valP(d_valP)
);

regE regE1(
	.clk(clk),
	.d_status(d_status),
	.d_icode(d_icode),
	.d_ifun(d_ifun),
	.d_rA(d_rA),
	.d_rB(d_rB),
	.d_valC(d_valC),
	.d_valP(d_valP),
	.d_valA(d_valA),
	.d_valB(d_valB),
	
	.e_status(e_status),
	.e_icode(e_icode),
	.e_ifun(e_ifun),
	.e_rA(e_rA),
	.e_rB(e_rB),
	.e_valC(e_valC),
	.e_valP(e_valP),
	.e_valA(e_valA),
	.e_valB(e_valB)
);

regM regM1(
	.clk(clk),
	.e_status(e_status),
	.e_icode(e_icode),
	.e_rA(e_rA),
	.e_rB(e_rB),
	.e_valC(e_valC),
	.e_valP(e_valP),
	.e_valA(e_valA),
	.e_valB(e_valB),
	.e_cnd(e_cnd),
	.e_valE(e_valE),
	
	.m_status(m_status),
	.m_icode(m_icode),
	.m_rA(m_rA),
	.m_rB(m_rB),
	.m_valC(m_valC),
	.m_valP(m_valP),
	.m_valA(m_valA),
	.m_valB(m_valB),
	.m_cnd(m_cnd),
	.m_valE(m_valE)

);

regW regW1(
	.clk(clk),
	.m_status(m_status),
	.m_icode(m_icode),
	.m_rA(m_rA),
	.m_rB(m_rB),
	.m_valC(m_valC),
	.m_valP(m_valP),
	.m_valA(m_valA),
	.m_valB(m_valB),
	.m_cnd(m_cnd),
	.m_valE(m_valE),
	.m_valM(m_valM),
	
	.w_status(w_status),
	.w_icode(w_icode),
	.w_rA(w_rA),
	.w_rB(w_rB),
	.w_valC(w_valC),
	.w_valP(w_valP),
	.w_valA(w_valA),
	.w_valB(w_valB),
	.w_cnd(w_cnd),
	.w_valE(w_valE),
	.w_valM(w_valM)
);
	

	
always #2 clk=~clk;

initial begin
	$dumpfile("0_proc_wrapper.vcd");
	//$monitor("instr=%b", fetch1.instr);
	$monitor("clk=%d f_icode=%d d_icode=%d e_icode=%d valE=%x  m_icode=%d w_icode=%d status=%d\n", clk, f_icode, d_icode, e_icode, e_valE, m_icode, w_icode, status[2]);
	//$monitor("PC=", PC);
	status[0] = 1'b1;
	status[1] = 1'b0;
	status[2] = 1'b0;
	clk = 0;
	PC = 64'b0;
	//valA = 64'b0;
	//valB = 64'b0;
	//valC = 64'b0;
	//valE = 64'b0;
	//valM = 64'b0;
end

always@(posedge clk)
begin
	// lifeblood of a processor
	PC = updated_PC;
	
	// error handling
	if(hltins) // halt or not
	begin
		status[0] = 1'b0;
		status[1] = 1'b0;
		status[2] = hltins; // hlt=1
	end
	else if(instr_validity==1'b0)
	begin
		status[0] = 1'b0;
		status[1] = instr_validity; // invalid
		status[2] = 1'b0;
	end
	else
	begin
		status[0] = 1'b1; // everything A-OK
		status[1] = 1'b0;
		status[2] = 1'b0;
	end
	if(status[2]==1'b1)
	begin
		$finish;
	end
	
end

endmodule



