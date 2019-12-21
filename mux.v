/*
    *   @author: Shubhayu Das
*/
module mux#(parameter SIZE = 32)(A, B, select, out);

input [SIZE-1:0]A, B;
input select;

output [SIZE-1:0] out;

assign out = select ? B : A;
endmodule