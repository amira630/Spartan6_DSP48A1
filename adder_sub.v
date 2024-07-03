module adder_subtracter(A,B,cin,operation,result,carryout);
parameter DATA_WIDTH = 18;
input [DATA_WIDTH-1:0] A,B;
input cin,operation;
output [DATA_WIDTH-1:0] result;
output carryout;

assign {carryout,result} = (operation)? (A-(B+cin)) : (A+(B+cin))  ;  

endmodule