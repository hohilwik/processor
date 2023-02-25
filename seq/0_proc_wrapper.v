`timescale 1ns / 1ps

`include "1_fetch.v"
`include "2_decode.v"
`include "3_execute.v"
`include "4_memory.v"
`include "5_write_back.v"
`include "6_pc_update.v"

module proc;
	reg clk;
	reg [63:0] PC;
	reg status[2:0]; //halt, instr_validity, OK
	
	wire [3:0] icode;
	wire [3:0] ifun;
	wire [3:0] rA;
	wire [3:0] rB;
	wire [63:0] valC;
	wire [63:0] valP;
	wire [63:0] valA;
	wire [63:0] valB;
	wire [63:0] valE;
	wire [63:0] valM;
	wire [63:0] readback;
	wire [63:0] updated_PC;
	
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
	
//module fetch_ins
//module decode_ins
//module execute_ins
//module memory
//module write_back
//module pc_update

fetch_ins fetch1(
	.clk(clk),
	.PC(PC),
	.icode(icode),
	.ifun(ifun),
	.rA(rA),
	.rB(rB),
	.valC(valC),
	.valP(valP),
	.instr_validity(instr_validity),
	.imem_error(imem_error),
	.hlt(hltins)
	, .proc_mem(proc_mem)
	);

decode_ins decode1(
	.clk(clk),
	.cnd(cnd),
	.icode(icode),
	.rA(rA),
	.rB(rB),
	.valA(valA),
	.valB(valB),
	.valE(valE),
	.valM(valM),
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
	.icode(icode),
	.ifun(ifun),
	.vflag(vflag),
	.valA(valA),
	.valB(valB),
	.valC(valC),
	.valE(valE),
	.cnd(cnd),
	.zflag(zflag),
	.sflag(sflag),
	.oflag(oflag)
	
	);

memory memory1(
	.clk(clk),
	.icode(icode),
	.valA(valA),
	.valB(valB),
	.valE(valE),
	.valP(valP),
	.valM(valM),
	.readback(readback)
	//, .proc_mem(proc_mem)
	);

write_back wb1(
	.clk(clk),
	.cnd(cnd),
	.icode(icode),
	.rA(rA),
	.rB(rB),
	.valA(valA),
	.valB(valB),
	.valE(valE),
	.valM(valM),
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
	.cnd(cnd),
	.PC(PC),
	.icode(icode),
	.valC(valC),
	.valP(valP),
	.valM(valM),
	.updated_PC(updated_PC)
	);
	
always #2 clk=~clk;

initial begin
	$dumpfile("0_proc_wrapper.vcd");
	$monitor("clk=%d icode=%d ifun=%d rA=%d rB=%d r4=%d r5=%d valE=%d halt=%d\n", clk, icode, ifun, rA, rB, reg_mem4, reg_mem5, valE, status[2]);
	status[0] = 1'b1;
	status[1] = 1'b0;
	status[2] = 1'b0;
	clk = 0;
	PC = 64'b0;
end

always@(*)
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


	

	