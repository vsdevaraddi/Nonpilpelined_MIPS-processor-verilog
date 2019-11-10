//Sign extend module

module Sign_extend(out,in,clk);
input[15:0] in;
input clk;
output[31:0] out;
reg[31:0] out;

always @(posedge clk) begin
    out[15:0]=in;
    if(in[15]==1'b1)begin
        out[31:16]=16'd65535;
    else begin
        out[31:16=16'd0;
    end
end
endmodule