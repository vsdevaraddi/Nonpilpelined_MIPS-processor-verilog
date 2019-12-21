// @author: all

module syncAdder(clk, A, B, out);
    input clk;
    input [31:0]A, B;
    output reg [31:0]out;
    always @(posedge clk)
        out = A+B;
endmodule