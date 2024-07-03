module REG_MUX(in, clk, rst, en, out);
	parameter REG_WIDTH =18, REG_SEL=1, RST_TYPE="SYNC";
	input [REG_WIDTH-1:0] in; 
	input rst, clk, en;
	output [REG_WIDTH-1:0] out; 
	
	generate
		if (REG_SEL) 
			Register #(.REG_WIDTH(REG_WIDTH), .RST_TYPE(RST_TYPE)) REG(in, rst, clk, en, out);
		else 
			assign out = in;	 
	endgenerate
endmodule
