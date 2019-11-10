//registers module
module Registers(readData1,readData2,readRegister1,readRegister2,regWrite,writeRegister,writeData,clk);
input[4:0] readRegister1,readRegister2,writeRegister;
input regWrite,clk;
input[31:0] writeData;
output[31:0] readData1,readData2;
reg[31:0] readData1,readData2;

//registers which stores data
reg[31:0] registers[31:0];//registers created

initial begin
    integer i;
    for(i=0;i<32;i=i+1)begin
        reg[i]=32'd0;
    end
end
always @(posedge clk) begin
    readData1 <= registers[readRegister1];
    readData2 <= registers[readRegister2];
end
always @(negedge clk) begin
    if(regWrite==1'd1) begin
        registers[writeRegister]=writeData;
    end
end
endmodule
