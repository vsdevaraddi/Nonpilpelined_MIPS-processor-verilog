/*
  * @author: Aniruddh
*/

module dataMemory(clk, adr, writeIn, readOut, writePin, readPin);

input clk;
input [31:0] adr;
input [31:0] writeIn;
input writePin;
input readPin;
integer file, i;
output reg [31:0]readOut;

reg [31:0]memBlock[0:7];

initial
begin
   $readmemb("dataMem.dat", memBlock);
end

always @(posedge clk)
begin
  if(writePin == 1) begin
    memBlock[adr] = writeIn;
    //  File output
    file = $fopen("dataMem.dat", "w");
    for (i = 0; i<8; i=i+1)
      $fdisplay(file,"%b",memBlock[i]);
    $fclose(file);


  end
  if(readPin == 1) readOut = memBlock[adr];
end
endmodule

// module tb;
//   reg clk, writePin, readPin;
//   reg[31:0] adr, writeIn;
//   wire[31:0] readOut;

//   dataMemory uut(clk, adr, writeIn, readOut, writePin, readPin);

//   always #1 clk = ~clk;
//   initial begin
//     clk = 0;
//     writePin = 1;
//     writeIn = 32'b111;
//     adr = 32'b11;
//     #10;
//     writeIn = 32'b111;
//     adr = 32'b11;

//     $finish;
//   end
// endmodule
