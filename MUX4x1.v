module MUX4x1(in0, in1, in2, in3, sel, out);
	input [47:0] in0, in1, in2, in3;
	input [1:0] sel;
	output [47:0] out;
	assign out = (sel == 0)? in0 : (sel == 1)? in1 : (sel == 2)? in2 : in3;
endmodule