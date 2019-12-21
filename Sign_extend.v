/*
    * Sign extend module
    * @author: Veerendra
*/

module Sign_extend(out,in);
input[15:0] in;
output[31:0] out;
reg[31:0] out;

always @(*) begin
    out[15:0]=in;
    if(in[15]==1'b1)begin
        out[31:16]=16'd65535;
    end
    else begin
        out[31:16]=16'd0;
    end
end
endmodule

// module tb();
// reg[15:0] in;
// wire[31:0] out;

// Sign_extend uut(out,in);

// initial begin
//     $dumpfile("output.vcd");
//     $dumpvars(0,tb);
//     in=16'd1;
//     #1 in=16'd12;
//     #1 in=16'd65535;
//     #1 in=16'd0; 

// end
// endmodule