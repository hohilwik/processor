`timescale 1ns / 1ps

module memory(clk, icode, valA, valB, valE, valP, valM, readback
//, proc_mem
);//(
	input clk;
	input [3:0] icode;
	input [63:0] valA;
	input [63:0] valB;
	input [63:0] valE;
	input [63:0] valP;
	output reg [63:0] valM;
	output reg [63:0] readback;
	//input wire [7:0] proc_mem[0:4095];
	reg [7:0] data_mem[0:4095];
	//);
	
	
	integer marker;
	reg [63:0] valpass;
	
	always@(*)
	begin
		//data_mem = proc_mem;
		//rmmovq
		if(icode==4'b0100)
		begin
			valpass = valA;
			marker=1;
		end
		
		//mrmovq
		else if(icode==4'b0101)
		begin
			valpass = valE;
			marker=0;
		end
		//call
		else if(icode==4'b1000)
		begin
			valpass = valP;
			marker=1;
		end
		//ret
		else if(icode==4'b1001)
		begin
			valpass = valA;
			marker=0;
		end
		//pushq
		else if(icode==4'b1010)
		begin
			valpass = valA;
			marker=1;
		end
		//popq
		else if(icode==4'b1011)
		begin
			valpass = valA;
			marker=0;
		end
		
		if(marker==1)
		begin
			//datamem[valE]=valA
			data_mem[valE]   = valpass[63:56];
			data_mem[valE+1] = valpass[55:48];
			data_mem[valE+2] = valpass[47:40];
			data_mem[valE+3] = valpass[39:32];
			data_mem[valE+4] = valpass[31:24];
			data_mem[valE+5] = valpass[23:16];
			data_mem[valE+6] = valpass[15:8];
			data_mem[valE+7] = valpass[7:0];
		end
		else if(marker==0)
		begin
			//valM=datamem[valE]
			valM = {
			data_mem[valpass],
			data_mem[valpass+1],
			data_mem[valpass+2],
			data_mem[valpass+3],
			data_mem[valpass+4],
			data_mem[valpass+5],
			data_mem[valpass+6],
			data_mem[valpass+7]
			};
			
		end
		
		//readback = valM;
	
	
	end
	
endmodule