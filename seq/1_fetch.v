`timescale 1ns/ 1ps

module fetch_ins(
	input clk,
	input [63:0] PC,
	output reg [3:0] icode,
	output reg [3:0] ifun,
	output reg [3:0] rA,
	output reg [3:0] rB,
	output reg [63:0] valC,
	output reg [63:0] valP,
	output reg instr_validity,
	output reg imem_error,
	output reg hlt
	};
	
	reg [7:0] proc_mem[0:4095];
	reg [0:79] instr; // max instruction length is 10 bytes
	
	// placeholder for scanf simplicity
	reg [0:7] buffer[0:2047];
	
	
	integer asm_bin_p; // file pointer for binary file
	
	initial begin
	   // read from binary file and load into memory
	   
	   integer iterlines=0, iterbits=0;
	   integer ii=0;
	   
	   asm_bin_p = $fopen("prog_binary.out", r);
	   while( !feof(asm_bin_p) ) begin
			$fscanf(asm_file_p, "%b", buffer[iterlines][iterbits]);
			iterbits=iterbits+1;
			if(iterbits>=8) 
			begin
				iterlines=iterlines+1;
				iterbits=0;
			end
				
		end
		
		while(ii<=iterlines)
		begin
			proc_mem[ii] = buffer[ii];
			ii = ii+1;
		end
		
	end
	
	always@(posedge clk)
	begin
		
		imem_error=0;
		if(PC>2047)
		begin
			imem_error=1;
		end
		
		instr = {
			proc_mem[PC],
			proc_mem[PC+1],
			proc_mem[PC+2],
			proc_mem[PC+3],
			proc_mem[PC+4],
			proc_mem[PC+5],
			proc_mem[PC+6],
			proc_mem[PC+7],
			proc_mem[PC+8],
			proc_mem[PC+9]
			};
		
		icode = instr[0:3]; // high nibble
		ifun = instr[4:7]; //low nibble
		
		instr_validity = 1'b1;
		
		// go through all icode cases
		// halt 0x00
		if(icode==4'b0000)
		begin
			hlt=1;
			valP = PC+64'd1;
		end
		// nop 0x10
		else if(icode==4'b0001)
		begin
			valP = PC+64'd1;
		end
		// cmovxx 0x2Fn
		else if(icode==4'b0010)
		begin
			rA = instr[8:11]; // register number
			rB = instr[12:15]; // register number
			valP = PC+64'd2;
		end
		// irmov 0x30
		else if(icode==4'b0011)
		begin
			rA = instr[8:11]; // register number
			rB = instr[12:15]; // register number
			valC = instr[16:79];
			valP = PC+64'd10;
		end
		// rmmov 0x40
		else if(icode==4'b0100)
		begin
			rA = instr[8:11]; // register number
			rB = instr[12:15]; // register number
			valC = instr[16:79];
			valP = PC+64'd10;
		end
		// mrmov 0x50
		else if(icode==4'b0101)
		begin
			rA = instr[8:11]; // register number
			rB = instr[12:15]; // register number
			valC = instr[16:79];
			valP = PC+64'd10;
		end
		// OP 0x6Fn	
		else if(icode==4'b0110)
		begin
			rA = instr[8:11]; // register number
			rB = instr[12:15]; // register number
			valP = PC+64'd2;
		end
		// jXX 0x7Fn	
		else if(icode==4'b0111)
		begin
			valC = instr[8:71];
			valP = PC+64'd9;
		end
		// call 0x80
		else if(icode==4'b1000)
		begin
			valC = instr[8:71];
			valP = PC+64'd9;
		end
		// ret 0x90	
		else if(icode==4'b1001)
		begin
			valP = PC+64'd1;
		end
		// pushq 0xa0	
		else if(icode==4'b1010)
		begin
			rA = instr[8:11]; // register number
			rB = instr[12:15]; // register number
			valP = PC+64'd2;
		end
		// popq 0xb0	
		else if(icode==4'b1011)
		begin
			rA = instr[8:11]; // register number
			rB = instr[12:15]; // register number
			valP = PC+64'd2;
		end
		else begin
			instr_validity=1'b0;
		end
		
		
		
	
	
	end
	
	endmodule
	