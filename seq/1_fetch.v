`timescale 1ns/ 1ps

module fetch_ins(clk, PC, icode, ifun, rA, rB, valC, valP, instr_validity, imem_error, hlt, proc_mem); //(
	input clk;
	input [63:0] PC;
	output reg [3:0] icode;
	output reg [3:0] ifun;
	output reg [3:0] rA;
	output reg [3:0] rB;
	output reg [63:0] valC;
	output reg [63:0] valP;
	output reg instr_validity;
	output reg imem_error;
	output reg hlt;
	output reg [7:0] proc_mem[0:4095];
	//};
	
	//reg [7:0] proc_mem[0:4095];
	reg [0:79] instr; // max instruction length is 10 bytes
	reg [79:0] instr2;
	
	// placeholder for scanf simplicity
	reg [0:7] buffer[0:4095];
	
	
	integer asm_bin_p; // file pointer for binary file
	integer iterlines=0, iterbits=0;
	integer ii=0;
	integer status;
	reg tempbit;
	
	//integer index;
	//initial $readmemb("prog_bin.out",proc_mem);
	//always @index DATA_REG = memory[index];
	
	initial begin
		//$display("%x", buffer[0]);
	   // read from binary file and load into memory
	   
	   //$readmemb("prog_binary.out", buffer);
	   //while(ii<20)
	   //begin
		//$display("%8b", buffer[ii]);
		//ii = ii+1;
	   //end
	   //while(ii<190)
	   //begin
		//  proc_mem[ii] = buffer[ii];
	   //end
	   
	   //asm_bin_p = $fopen("prog_bin.out", "r");
	   //while( !$feof(asm_bin_p) ) 
	   //begin
			
			//status = $fscanf(asm_bin_p, "%b", buffer[0]);
			//$display("%b", buffer[0]);
			//proc_mem[ii] = buffer[0];
			//ii = ii+1;
			//proc_mem[ii] = buffer[ii];
			//ii = ii+1;
			//$fscanf(asm_bin_p, "%b", tempbit);
			//buffer[iterlines][iterbits] = tempbit;
			//iterbits=iterbits+1;
			//if(iterbits>=8) 
			//begin
			//	iterlines=iterlines+1;
			//	iterbits=0;
			//end
				
		//end
		//while(ii<=2000)
		//begin
		//	proc_mem[ii] = buffer[ii];
		//	ii = ii+1;
		//end
		/*
		proc_mem[0] = 8'h30;
		proc_mem[1] = 8'hf4;
		proc_mem[2] = 8'h00;
		proc_mem[3] = 8'h01;
		proc_mem[4] = 8'h00;
		proc_mem[5] = 8'h00;
		proc_mem[6] = 8'h00;
		proc_mem[7] = 8'h00;
		proc_mem[8] = 8'h00;
		proc_mem[9] = 8'h00;
		proc_mem[10] = 8'h00;
		proc_mem[11] = 8'h00;
		proc_mem[12] = 8'h00;
		proc_mem[13] = 8'h00;
		proc_mem[14] = 8'h00;
		*/
		
		
		
		proc_mem[0] = 8'h30;
		proc_mem[1] = 8'hf4;
		proc_mem[2] = 8'h00;
		proc_mem[3] = 8'h01;
		proc_mem[4] = 8'h00;
		proc_mem[5] = 8'h00;
		proc_mem[6] = 8'h00;
		proc_mem[7] = 8'h00;
		proc_mem[8] = 8'h00;
		proc_mem[9] = 8'h00;
		proc_mem[10] = 8'h30;
		proc_mem[11] = 8'hf5;
		proc_mem[12] = 8'h00;
		proc_mem[13] = 8'h01;
		proc_mem[14] = 8'h00;
		proc_mem[15] = 8'h00;
		proc_mem[16] = 8'h00;
		proc_mem[17] = 8'h00;
		proc_mem[18] = 8'h00;
		proc_mem[19] = 8'h00;
		proc_mem[20] = 8'h80;
		proc_mem[21] = 8'h40;
		proc_mem[22] = 8'h00;
		proc_mem[23] = 8'h00;
		proc_mem[24] = 8'h00;
		proc_mem[25] = 8'h00;
		proc_mem[26] = 8'h00;
		proc_mem[27] = 8'h00;
		proc_mem[28] = 8'h00;
		proc_mem[29] = 8'h00;
		proc_mem[30] = 8'h00;
		proc_mem[31] = 8'h00;
		proc_mem[32] = 8'h0d;
		proc_mem[33] = 8'h00;
		proc_mem[34] = 8'h00;
		proc_mem[35] = 8'h00;
		proc_mem[36] = 8'h00;
		proc_mem[37] = 8'h00;
		proc_mem[38] = 8'h00;
		proc_mem[39] = 8'h00;
		proc_mem[40] = 8'hc0;
		proc_mem[41] = 8'h00;
		proc_mem[42] = 8'h00;
		proc_mem[43] = 8'h00;
		proc_mem[44] = 8'h00;
		proc_mem[45] = 8'h00;
		proc_mem[46] = 8'h00;
		proc_mem[47] = 8'h00;
		proc_mem[48] = 8'h00;
		proc_mem[49] = 8'h0b;
		proc_mem[50] = 8'h00;
		proc_mem[51] = 8'h00;
		proc_mem[52] = 8'h00;
		proc_mem[53] = 8'h00;
		proc_mem[54] = 8'h00;
		proc_mem[55] = 8'h00;
		proc_mem[56] = 8'h00;
		proc_mem[57] = 8'ha0;
		proc_mem[58] = 8'h00;
		proc_mem[59] = 8'h00;
		proc_mem[60] = 8'h00;
		proc_mem[61] = 8'h00;
		proc_mem[62] = 8'h00;
		proc_mem[63] = 8'h00;
		proc_mem[64] = 8'ha0;
		proc_mem[65] = 8'h5f;
		proc_mem[66] = 8'h20;
		proc_mem[67] = 8'h45;
		proc_mem[68] = 8'h30;
		proc_mem[69] = 8'hf0;
		proc_mem[70] = 8'h04;
		proc_mem[71] = 8'h00;
		proc_mem[72] = 8'h00;
		proc_mem[73] = 8'h00;
		proc_mem[74] = 8'h00;
		proc_mem[75] = 8'h00;
		proc_mem[76] = 8'h00;
		proc_mem[77] = 8'h00;
		proc_mem[78] = 8'h00;
		proc_mem[79] = 8'h00;
		proc_mem[80] = 8'h00;
		proc_mem[81] = 8'h00;
		
		
		
		//proc_mem[4095] = 8'b0;
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		//proc_mem[0] = 8'h
		
		
	end
	
	always@(*)
	begin
		
		imem_error=0;
		if(PC>4095)
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
		
		instr2 = {
			proc_mem[PC+9],
			proc_mem[PC+8],
			proc_mem[PC+7],
			proc_mem[PC+6],
			proc_mem[PC+5],
			proc_mem[PC+4],
			proc_mem[PC+3],
			proc_mem[PC+2],
			proc_mem[PC+1],
			proc_mem[PC]
			};
				
			
		$display("instr=%x", instr);
		
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
			valC = instr2[79:16];
			valP = PC+64'd10;
		end
		// rmmov 0x40
		else if(icode==4'b0100)
		begin
			rA = instr[8:11]; // register number
			rB = instr[12:15]; // register number
			valC = instr2[79:16];
			valP = PC+64'd10;
		end
		// mrmov 0x50
		else if(icode==4'b0101)
		begin
			rA = instr[8:11]; // register number
			rB = instr[12:15]; // register number
			valC = instr2[79:16];
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
			valC = instr2[71:8];
			valP = PC+64'd9;
		end
		// call 0x80
		else if(icode==4'b1000)
		begin
			valC = instr2[71:8];
			valP = instr[8:15];//PC+64'd9;
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
		
		$display("rA=%d, rB=%d, valP=%d", rA, rB, valP);
		
	
	
	end
	
	endmodule
	