/*
  * @author: Aniruddh
*/

module alucontrol(aluop, fn, out);

input [0:1]aluop;
input [0:5]fn;
output reg [0:2]out;

always @(aluop, fn)
begin
  if(aluop == 0) out = 2;
  else if(aluop == 1) out = 3;
  else if(aluop == 2)
  begin
    if(fn == 6'b100000) out = 2;
    else if(fn == 6'b100010) out = 3;
    else if(fn == 6'b100100) out = 0;
    else if(fn == 6'b100101) out = 1;
    else if(fn == 6'b101010) out = 4;
  end
  else out = 5;
end

endmodule


// module tb_alucon;

// reg [0:1] aluop;
// reg [0:5] fn;
// wire [0:2]out;

// alucontrol uut(aluop, fn, out);

// initial begin
//   $dumpfile("alucontrol.vcd");
//   $dumpvars(0, tb_alucon);

//   aluop = 0;
//   #10;
//   aluop = 1;
//   #10;
//   aluop = 2;
//   fn = 6'b100000;
//   #10;
//   fn = 6'b100010;
//   #10;
//   fn = 6'b100100;
//   #10;
//   fn = 6'b100101;
//   #10;
//   fn = 6'b101010;
//   #10;
// end
// endmodule
