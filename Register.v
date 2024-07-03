module Register(in, rst, clk, en, out);
	parameter REG_WIDTH =18;
	parameter RST_TYPE ="SYNC";

	input [REG_WIDTH-1:0] in;
	input rst, clk, en;
	output reg [REG_WIDTH-1:0] out;
	
	generate
		if (RST_TYPE == "SYNC") begin
			always @(posedge clk ) begin
				if (rst) begin
					out <= 'b0;
				end
				else if(en)
					out <= in;
			end
		end
		else if(RST_TYPE == "ASYNC") begin
			always @(posedge clk or posedge rst) begin
				if (rst) begin
					out <= 'b0;
				end
				else if(en)
					out <= in;
			end
		end
	endgenerate
endmodule