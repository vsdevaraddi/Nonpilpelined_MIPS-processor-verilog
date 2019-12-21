/*
    * registers module
    * @author: Veerendra
*/

module Registers(readData1,readData2,readRegister1,readRegister2,regWrite,writeRegister,writeData,clk);
input[4:0] readRegister1,readRegister2,writeRegister;
input regWrite,clk;
input[31:0] writeData;
output[31:0] readData1,readData2;
reg[31:0] readData1,readData2;
integer i;
//registers which stores data
reg[31:0] registers[31:0];//registers created

initial begin
    
    for(i=0;i<32;i=i+1)begin
        registers[i]=32'd0;
    end
end
always @(posedge clk) begin
    $display("%d %d %d %d", registers[1], registers[2], registers[8], registers[9]);
    readData1 <= registers[readRegister1];
    readData2 <= registers[readRegister2];
end
always @(negedge clk) begin
    if(regWrite==1'd1) begin
        registers[writeRegister]=writeData;
    end
end
endmodule

// module tb();
// reg[4:0] readRegister1,readRegister2,writeRegister;
// reg regWrite,clk;
// reg[31:0] writeData;
// wire[31:0] readData1,readData2;

// Registers uut(readData1,readData2,readRegister1,readRegister2,regWrite,writeRegister,writeData,clk);
// initial begin
//     $dumpfile("output.vcd");
//     $dumpvars(0,tb);
//     clk=1'b1;
//     readRegister1=4'd0;
//     readRegister2=4'd1;
//     writeRegister=4'd0;
//     regWrite=1'b1;
//     writeData=32'd9;
//     #1 clk=1'b0;
//     #1 clk=1'b1;
//     #1 clk=1'd0;
// end
// endmodule