`timescale 1ns / 1ps

module decode_ins(
  input clk,
  input cnd,
  input [3:0] icode,
  input [3:0] rA,
  input [3:0] rB,
  output reg [63:0] valA,
  output reg [63:0] valB,
  output reg vflag,
  input reg [63:0] valE,
  input reg [63:0] valM,
  output reg [63:0] reg_mem0,
  output reg [63:0] reg_mem1,
  output reg [63:0] reg_mem2,
  output reg [63:0] reg_mem3,
  output reg [63:0] reg_mem4,
  output reg [63:0] reg_mem5,
  output reg [63:0] reg_mem6,
  output reg [63:0] reg_mem7,
  output reg [63:0] reg_mem8,
  output reg [63:0] reg_mem9,
  output reg [63:0] reg_mem10,
  output reg [63:0] reg_mem11,
  output reg [63:0] reg_mem12,
  output reg [63:0] reg_mem13,
  output reg [63:0] reg_mem14
);

  // lil buffer
  reg [63:0] reg_mem[0:14];

  always@(*)
  begin
	vflag=0;
	//cmovxx
    if(icode==4'b0010) 
    begin
      valA=reg_mem[rA];
    end
	//rmmovq
    else if(icode==4'b0100) 
    begin
      valA=reg_mem[rA];
      valB=reg_mem[rB];
	  vflag=1;
    end
	//mrmovq
    else if(icode==4'b0101) 
    begin
      valB=reg_mem[rB];
    end
	//OPq
    else if(icode==4'b0110) 
    begin
      valA=reg_mem[rA];
      valB=reg_mem[rB];
	  vflag=1;
    end
	//call
    else if(icode==4'b1000) 
    begin
      valB=reg_mem[4]; //rsp
    end
	//ret
    else if(icode==4'b1001) 
    begin
      valA=reg_mem[4]; //rsp
      valB=reg_mem[4]; //rsp
	  vflag=1;
    end
	//pushq
    else if(icode==4'b1010) 
    begin
      valA=reg_mem[rA];
      valB=reg_mem[4]; //rsp
	  vflag=1;
    end
	//popq
    else if(icode==4'b1011) 
    begin
      valA=reg_mem[4]; //rsp
      valB=reg_mem[4]; //rsp
	  vflag=1;
    end
	
	// write from buffer to registers
    reg_mem0=reg_mem[0];
    reg_mem1=reg_mem[1];
    reg_mem2=reg_mem[2];
    reg_mem3=reg_mem[3];
    reg_mem4=reg_mem[4];
    reg_mem5=reg_mem[5];
    reg_mem6=reg_mem[6];
    reg_mem7=reg_mem[7];
    reg_mem8=reg_mem[8];
    reg_mem9=reg_mem[9];
    reg_mem10=reg_mem[10];
    reg_mem11=reg_mem[11];
    reg_mem12=reg_mem[12];
    reg_mem13=reg_mem[13];
    reg_mem14=reg_mem[14];
  end

endmodule