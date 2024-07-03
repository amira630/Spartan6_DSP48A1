module DSP_48A1_tb(); 

parameter A0REG=1'b0, A1REG=1'b1, B0REG=1'b0, B1REG=1'b1, CREG=1'b1, DREG=1'b1, MREG=1'b1, PREG=1'b1, 
		CARRYINREG=1'b1, CARRYOUTREG=1'b1, OPMODEREG=1'b1, CARRYINSEL="OPMODE5", B_INPUT="DIRECT", RSTTYPE="SYNC";
reg [17:0] A,B,D,BCIN;
reg [47:0] C;
reg clk,RSTA,RSTB,RSTC,RSTD,RSTOPMODE,RSTM,RST_CARRYIN,RSTP;
reg CEA,CEB,CED,CEC,CE_OPMODE,CEM,CE_CARRYIN,CEP;
reg CARRYIN;
reg [47:0] PCIN; 
reg [7:0] opmode;
wire [17:0] BCOUT;
wire [35:0] M;
wire [47:0] P,PCOUT;
wire CARRYOUT,CARRYOUTF;
Spartan6_DSP48A1 dut(A, B, C, D, clk, CARRYIN, opmode, BCIN, 
						RSTA, RSTB, RSTC, RSTD, RSTM, RSTP, RST_CARRYIN, RSTOPMODE, 
						CEA, CEB, CEC, CED, CEM, CEP, CE_CARRYIN, CE_OPMODE, PCIN, 
						BCOUT, PCOUT, M, P,CARRYOUT, CARRYOUTF);


initial begin
	clk=0;
	forever begin
		#2	clk=~clk;
	end
end
initial begin
	RSTB=1;
	RSTD=1;
	#50;
	repeat (20) begin
		D=$random;
		B=$random;
		@(negedge clk);
	end
	RSTB=0;
	RSTD=0;
	RSTA=0;
	RSTC=0;
	RSTOPMODE=0;
	RSTM=0;
	RST_CARRYIN=0;
	RSTP=0;
	CEB=1;
	CED=1;
	CEA=1;
	CEC=1;
	CE_OPMODE=1;
	CEM=1;
	CE_CARRYIN=1;
	CEP=1;
	#2;
	repeat (20) begin
		A=5;
		C=60;
		D=7;
		B=2;
		BCIN=11;
		opmode[6]=0;
		opmode[4]=1;
		CARRYIN=0;
		PCIN='b0;
		opmode[1:0]=2'b01;
		opmode[3:2]=2'b11;
		opmode[5]=1'b1;
		opmode[7]=1;
		@(negedge clk);
	end
	#2;
	RSTB=1;
	RSTD=1;
	RSTA=1;
	RSTC=1;
	RSTOPMODE=1;
	RSTM=1;
	RST_CARRYIN=1;
	RSTP=1;
	#2;
	RSTB=0;
	RSTD=0;
	RSTA=0;
	RSTC=0;
	RSTOPMODE=0;
	RSTM=0;
	RST_CARRYIN=0;
	RSTP=0;
	#2;
	repeat (20) begin
		A=5;
		C=3;
		D=7;
		B=2;
		BCIN=11;
		opmode[6]=1;
		opmode[4]=1;
		CARRYIN=0;
		PCIN=0;
		opmode[1:0]=2'b01;
		opmode[3:2]=2'b11;
		opmode[5]=1'b0;
		opmode[7]=0;
		@(negedge clk);
	end
	#2;
	RSTB=1;
	RSTD=1;
	RSTA=1;
	RSTC=1;
	RSTOPMODE=1;
	RSTM=1;
	RST_CARRYIN=1;
	RSTP=1;
	#2;
	RSTB=0;
	RSTD=0;
	RSTA=0;
	RSTC=0;
	RSTOPMODE=0;
	RSTM=0;
	RST_CARRYIN=0;
	RSTP=0;
	#2;
	repeat (20) begin
		A=5;
		C=60;
		D=7;
		B=2;
		BCIN=11;
		opmode[6]=0;
		opmode[4]=1;
		CARRYIN=0;
		PCIN=0;
		opmode[1:0]=2'b01;
		opmode[3:2]=2'b11;
		opmode[5]=1'b1;
		opmode[7]=0;
		@(negedge clk);
	end
	#2;
	RSTB=1;
	RSTD=1;
	RSTA=1;
	RSTC=1;
	RSTOPMODE=1;
	RSTM=1;
	RST_CARRYIN=1;
	RSTP=1;
	#2;
	RSTB=0;
	RSTD=0;
	RSTA=0;
	RSTC=0;
	RSTOPMODE=0;
	RSTM=0;
	RST_CARRYIN=0;
	RSTP=0;
	#2;
	repeat (20) begin
		A=5;
		C=60;
		D=7;
		B=2;
		BCIN=11;
		opmode[6]=1;
		opmode[4]=1;
		CARRYIN=0;
		PCIN=0;
		opmode[1:0]=2'b01;
		opmode[3:2]=2'b11;
		opmode[5]=1'b0;
		opmode[7]=1;
		@(negedge clk);
	end
	#2;
	RSTB=1;
	RSTD=1;
	RSTA=1;
	RSTC=1;
	RSTOPMODE=1;
	RSTM=1;
	RST_CARRYIN=1;
	RSTP=1;
	#2;
	RSTB=0;
	RSTD=0;
	RSTA=0;
	RSTC=0;
	RSTOPMODE=0;
	RSTM=0;
	RST_CARRYIN=0;
	RSTP=0;
	#2;
	repeat (30) begin
		A=5;
		C=60;
		D=7;
		B=2;
		BCIN=11;
		opmode[6]=1;
		opmode[4]=0;
		CARRYIN=0;
		PCIN=0;
		opmode[1:0]=$random;
		opmode[3:2]=$urandom_range(0,2);
		opmode[5]=1'b0;
		opmode[7]=1;
		@(negedge clk);
	end
	#2 $stop;
end
endmodule








