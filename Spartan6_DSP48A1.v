module Spartan6_DSP48A1(A, B, C, D, CLK, CARRYIN, OPMODE, BCIN, 
						RSTA, RSTB, RSTC, RSTD, RSTM, RSTP, RSTCARRYIN, RSTOPMODE, 
						CEA, CEB, CEC, CED, CEM, CEP, CECARRYIN, CEOPMODE, PCIN, 
						BCOUT, PCOUT, M, P,CARRYOUT, CARRYOUTF);

	parameter A0REG=1'b0, A1REG=1'b1, B0REG=1'b0, B1REG=1'b1, CREG=1'b1, DREG=1'b1, MREG=1'b1, PREG=1'b1, 
		CARRYINREG=1'b1, CARRYOUTREG=1'b1, OPMODEREG=1'b1, CARRYINSEL="OPMODE5", B_INPUT="DIRECT", RSTTYPE="SYNC";

	input [17:0] A, B, D, BCIN;
	input [47:0] C, PCIN;
	input [7:0] OPMODE;
	input CLK, CARRYIN, RSTA, RSTB, RSTC, RSTD, RSTM,
		  RSTP, RSTCARRYIN, RSTOPMODE, CEA, CEB, CEC, CED, CEM, CEP, CECARRYIN, CEOPMODE; 
	output [47:0] P, PCOUT;
	output [17:0] BCOUT;
	output [35:0] M;	  
	output CARRYOUT, CARRYOUTF;

	wire [7:0] OPMODE_MUX;
	wire [17:0] D_MUX, B_MUX0, A_MUX0, Pre_AdderMUX, Pre_AdderOUT, B_IN, A_MUX1, B_MUX1;
	wire [47:0] C_MUX, X_MUX, Z_MUX,M_MUX_extended, Post_AdderOUT, P_MUX;
	wire [35:0] MULT_OUT, M_MUX;
	wire CarryCascade_MUX, CYI_MUX, carryout, CYO_MUX;

	REG_MUX #(18, DREG , RSTTYPE) D_REG(D, CLK, RSTD, CED, D_MUX);
	REG_MUX #(8, OPMODEREG , RSTTYPE) OPMODE_REG(OPMODE, CLK, RSTOPMODE, CEOPMODE, OPMODE_MUX);
	generate
		if (B_INPUT=="DIRECT") 
			assign B_IN = B;
		else if(B_INPUT=="CASCADE")
			assign B_IN = BCIN;
		else 
			assign B_IN ='b0;	
	endgenerate

	REG_MUX #(18, B0REG, RSTTYPE) B0_REG(B_IN, CLK, RSTB, CEB, B_MUX0);
	REG_MUX #(18, A0REG, RSTTYPE) A0_REG(A, CLK, RSTA, CEA, A_MUX0);
	REG_MUX #(48, CREG, RSTTYPE) C_REG(C, CLK, RSTC, CEC, C_MUX);
	MUX2x1 Adder1MUX(B_MUX0, Pre_AdderOUT, OPMODE_MUX[4], Pre_AdderMUX);
	REG_MUX #(18, B1REG, RSTTYPE) B1_REG(Pre_AdderMUX, CLK, RSTB, CEB, B_MUX1);
	REG_MUX #(18, A1REG, RSTTYPE) A1_REG(A_MUX0, CLK, RSTA, CEA, A_MUX1);
	REG_MUX #(36, MREG, RSTTYPE) M_REG(MULT_OUT, CLK, RSTM, CEM, M_MUX);
	generate
		if (CARRYINSEL=="OPMODE5") 
			assign CarryCascade_MUX= OPMODE_MUX[5];
		else if(CARRYINSEL=="CARRYIN")
			assign CarryCascade_MUX = CARRYIN;
		else 
			assign CarryCascade_MUX ='b0;	
	endgenerate
	REG_MUX #(1, CARRYINREG, RSTTYPE) CYI(CarryCascade_MUX, CLK, RSTCARRYIN, CECARRYIN, CYI_MUX);
	assign M_MUX_extended = { {12 {M_MUX[35]} }, M_MUX };
	MUX4x1 X('b0, M_MUX_extended, P_MUX, {D[11:0], A, B}, OPMODE_MUX[1:0], X_MUX);
	MUX4x1 Z('b0, PCIN, P_MUX, C_MUX, OPMODE_MUX[3:2], Z_MUX);
	REG_MUX #(48, PREG, RSTTYPE) P_REG(Post_AdderOUT, CLK, RSTP, CEP, P_MUX);
	REG_MUX #(1, CARRYOUTREG, RSTTYPE) CYO(carryout, CLK, RSTCARRYIN, CECARRYIN, CYO_MUX);

	adder_subtracter Pre_adder_sub (D_MUX,B_MUX0,0,OPMODE_MUX[6],Pre_AdderOUT);
	adder_subtracter #(48) Post_adder_sub (Z_MUX,X_MUX,CYI_MUX,OPMODE_MUX[7],Post_AdderOUT,carryout);
	
	assign MULT_OUT = A_MUX1 * B_MUX1;
	assign BCOUT = B_MUX1; 
	assign M = M_MUX;
	assign CARRYOUT = CYO_MUX;
	assign CARRYOUTF = CYO_MUX;
	assign P = P_MUX;
	assign PCOUT = P_MUX;
	endmodule