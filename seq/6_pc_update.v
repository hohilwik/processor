`timescale 1ns / 1ps

module pc_update(
	input clk,
	input cnd,
	input [63:0] PC,
	input [3:0] icode,
	input [63:0] valC,
	input [63:0] valP,
	input [63:0] valM,
	output reg [63:0] updated_PC
	);
	
	
	always@(*)
	begin
		//jXX
		if(icode==4'b0111)
		begin
			if(cnd==1'b1)
			begin
				updated_PC = valC;
			end
			else
			begin
				updated_PC = valP;
			end
		end
		//call
		else if(icode==4'b1000)
		begin
			updated_PC = valC;
		end
		//ret
		else if(icode==4'b1001)
		begin
			updated_PC = valM;
		end
		else
		// all others
		begin
			updated_PC = valP;
		end
		
	end
	
endmodule