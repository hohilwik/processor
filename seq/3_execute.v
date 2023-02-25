`timescale 1ns / 1ps

// include stuff
`include "./alu/alu.v"

module execute_ins(clk, icode, ifun, vflag, valA, valB, valC, valE, cnd, zflag, sflag, oflag); //(
	input clk; 
	input [3:0] icode;
	input [3:0] ifun;
	output reg vflag;
	input [63:0] valA;
	input [63:0] valB;
	input [63:0] valC;
	output reg [63:0] valE;
	output reg cnd;
	output reg zflag;
	output reg sflag;
	output reg oflag;
	//);
	
reg a_sf;
reg b_sf;
	
always @(*)
	begin
		if(clk==1 && vflag==1)
		begin
			//I assume zflag is implemented as log64 levels of OR gates
			//sflag is just checking the sign bit
			//oflag is AND-OR logic with sign bits of A and B
			zflag = (aluOut==1'b0);
			sflag = (aluOut<1'b0);
			a_sf = (a<1'b0);
			b_sf = (b<1'b0);
			oflag = (a_sf==b_sf) && (sflag!=a_sf);
			// implement this with NOT-XOR, XOR, AND
		end
	end


//initial begin
	//zflag = 0;
	//sflag = 0;
	//oflag = 0;
//end

reg signed [63:0] tempans;
reg [1:0] control;
reg signed [63:0] a;
reg signed [63:0] b;
wire signed [63:0] aluOut;
wire overflow;

alu ALU1(
	.operation(control),
	.a(a),
	.b(b),
	.out(aluOut),
	.flag(overflow)
	);
	
reg Xin1, Xin2;
reg Oin1, Oin2;
reg Ain1, Ain2;
reg Nin1;
wire Xout, Oout, Aout, Nout;

xor gate1(Xout, Xin1, Xin2);
or gate2(Oout, Oin1, Oin2);
and gate3(Aout, Ain1, Ain2);
not gate4(Nout, Nin1);

initial begin
	zflag = 0;
	sflag = 0;
	oflag = 0;
	control=2'b00;
	a = 64'b0;
	b = 64'b0;
end

always@(*) begin
	if(clk==1)
	begin 
		cnd = 0;
		//cmovxx
		if(icode==4'b0010)
		begin
			//rrmovq
			if(ifun==4'b0000)
			begin
				cnd=1;
			end
			//cmovle
			else if(ifun==4'b0001)
			begin
			// (sflag^oflag) || oflag
				Xin1 = sflag;
				Xin2 = oflag;
				if(Xout || zflag)
				begin
					cnd = 1;
				end
			end
			//cmovl
			else if(ifun==4'b0010)
			begin
			// sflag^oflag
				Xin1 = sflag;
				Xin2 = oflag;
				if(Xout)
				begin
					cnd=1;
				end
			end
			//cmove
			else if(ifun==4'b0011)
			begin
				if(zflag)
				begin
					cnd=1;
				end
			end
			//cmovne
			else if(ifun==4'b0100)
			begin
				Nin1=zflag;
				if(Nout)
				begin
					cnd=1;
				end
			end
			//cmovge
			else if(ifun==4'b0101)
			begin
				Xin1 = sflag;
				Xin2 = oflag;
				#2
				Nin1 = Xout;
				if(Nout)
				begin
					cnd=1;
				end
			end
			//cmovg
			else if(ifun==4'b0110)
			begin
			// !(sflag^oflag)&&(!zflag)
				Xin1 = sflag;
				Xin2 = oflag;
				#2
				Nin1 = Xout;
				if(Nout)
				begin
					Nin1 = zflag;
					if(Nout)
					begin
						cnd=1;
					end
				end
			end	
		end
		//irmovq
		else if(icode==4'b0011)
		begin
			//valE = valC+64'd0
			control = 2'b00;
			a = valC;
			b = 64'd0;
			assign tempans = aluOut;
			valE = tempans;
		end
		//rmmovq
		else if(icode==4'b0100)
		begin
			 valE = valB+valC;
			//control = 2'b00
			//a = valC;
			//b = valB;
			//assign tempans = aluOut;
			//valE = tempans;
		end
		//mrmovq
		else if(icode==4'b0101)
		begin
			// valE = valB+valC
			control = 2'b00;
			a = valC;
			b = valB;
			assign tempans = aluOut;
			valE = tempans;
		end
		//OP
		else if(icode==4'b0110)
		begin
			control = ifun[3:2];
			a = valB;
			b = valA;
			assign tempans = aluOut;
			valE = tempans;
		end
		//jXX
		else if(icode==4'b0111)
		begin
			//jmp
			if(ifun==4'b0000)
			begin
				cnd = 1;
			end
			//jle
			else if(ifun==4'b0001)
			begin
				// (sflag^oflag)||oflag
				Xin1 = sflag;
				Xin2 = oflag;
				if(Xout || zflag)
				begin
					cnd=1;
				end
			end
			//jl
			else if(ifun==4'b0010)
			begin
				// sflag^oflag
				Xin1 = sflag;
				Xin2 = oflag;
				if(Xout)
				begin
					cnd=1;
				end
			end
			//je
			else if(ifun==4'b0011)
			begin
				if(zflag)
				begin
					cnd=1;
				end
			end
			//jne
			else if(ifun==4'b0100)
			begin
				Nin1 = zflag;
				if(Nout)
				begin
					cnd=1;
				end
			end
			//jge
			else if(ifun==4'b0101)
			begin
				// !(sflag^oflag)
				Xin1 = sflag;
				Xin2 = oflag;
				#2
				Nin1 = Xout;
				if(Nout)
				begin
					cnd = 1;
				end
			end
			//jg
			else if(ifun==4'b0110)
			begin
				// !(sflaf^oflag) && (!zflag)
				Xin1 = sflag;
				Xin2 = oflag;
				#2
				Nin1 = Xout;
				if(Nout)
				begin
					Nin1 = zflag;
					if(Nout)
					begin
						cnd = 1;
					end
				end
			
			end

		end
		//call
		else if(icode==4'b1000)
		begin
			// valE = valB-64'd8
			control = 2'b01;
			a = valB;
			b = 64'd8;
			assign tempans = aluOut;
			valE = tempans;
		end
		//ret
		else if(icode==4'b1001)
		begin
			// valE = valB+64'd8
			control = 2'b00;
			a = valB;
			b = 64'd8;
			assign tempans = aluOut;
			valE = tempans;
		end
		//pushq
		else if(icode==4'b1010)
		begin
			// valE = valB-64'd8
			control = 2'b01;
			a = valB;
			b = 64'd8;
			assign tempans = aluOut;
			valE = tempans;
		end
		//popq
		else if(icode==4'b1011)
		begin
			// valE = valB+64'd8
			control = 2'b00;
			a = valB;
			b = 64'd8;
			assign tempans = aluOut;
			valE = tempans;
		end
		
	end
end

endmodule