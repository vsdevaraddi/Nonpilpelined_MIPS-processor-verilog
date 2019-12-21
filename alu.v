/*
  * @author: Aniruddh
  * This ALU acceps a three-bit control, two 32-bit inputs and a clock.
  * It outputs a 32-bit output and a single bit to indicate if the output is zero.
*/

module alu(clk, in1, in2, control, out, zero);

input clk;
input [0:31]in1;
input [0:31]in2;
input [0:2]control;
output reg [0:31]out;
output reg zero;
integer i;

always @(posedge clk)
begin
  if (control == 3'b000)//and
  begin
    out = in1 & in2;
  end
  else if (control == 3'b001)//or
  begin
    out = in1 | in2;
  end
  else if (control == 3'b010)//add
  begin
    out = in1 + in2;
  end
  else if(control == 3'b011)//sub
  begin
    out = in1 - in2;
  end
  else if(control == 3'b100)//set on less than
  begin
    if(in1 < in2) out = 1;
    else out = 0;
  end

  if(out == 0) zero = 1;
  else zero = 0;
end
endmodule


// module tb_alu;

// reg [0:31]in1;
// reg [0:31]in2;
// reg [0:2]control;
// reg clk;
// wire [0:31]out;
// wire zero;

// alu uut(clk, in1, in2, control, out, zero);

// always  #3 clk = ~clk;
// initial
// begin
//   $dumpfile("alu_test.vcd");
//   $dumpvars(0, tb_alu);
//   clk = 0;
//   control = 0;
//   in1 = 7;
//   in2 = 3;
//   #6;
//   in1 = 8;
//   in2 = 3;
//   #6;
//   control = 1;
//   in1 = 24;
//   in2 = 6;
//   #6;
//   in1 = 6;
//   in2 = 2;
//   #6;
//   control = 2;
//   in1 = 11;
//   in2 = 12;
//   #6;
//   control = 3;
//   in1 = 1;
//   in2 = 13;
//   #6;
//   control = 3;
//   in1 = 12;
//   in2 = 12;
//   #6;
//   control = 4;
//   in1 = 3;
//   in2 = 4;
//   #6
//   in1 = 5;
//   in2= 3;
//   #6;
// end

// endmodule
