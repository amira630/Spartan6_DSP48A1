module MUX2x1(in0, in1, sel, out);
	parameter WIDTH = 18;
	input [WIDTH-1:0] in0, in1; 
	input sel;
	output [WIDTH-1:0] out;
	assign out = (sel == 0)? in0 : in1;
endmodule