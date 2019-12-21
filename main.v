`include "adder.v"
`include "syncAdder.v"
`include "alu.v"
`include "alucontrol.v"
`include "control.v"
`include "InstMem.v"
`include "mux.v"
`include "PC.v"
`include "registers.v"
`include "Sign_extend.v"
`include "leftshift.v"
`include "dataMem.v"

module main;
  //CLOCK
  reg clk; initial clk = 0; always #5 clk = ~clk;

//PROGRAM COUNTER
  wire [31:0]PCIn;
  wire [31:0]PCOut;
  wire PCEnable;
  PC programCounter(clk, PCIn, PCEnable, PCOut);
//INSTRUCTION MEMORY//
  wire [31:0]IMemOut;
  InstMem instructionMemory(clk, PCOut, IMemOut);

//REGISTER FILE
  wire [31:0]readData1;
  wire [31:0]readData2;
  wire regWriteEnable;
  wire [4:0]regWriteAddress;
  wire [31:0] regWriteData;
  wire regDst;
  mux#(.SIZE(5)) preRegisterMux(IMemOut[20:16], IMemOut[15:11],regDst,regWriteAddress);
  Registers registerFile(readData1,readData2,IMemOut[25:21],IMemOut[20:16],regWriteEnable, regWriteAddress, regWriteData, clk);

//SIGN EXTEND
  wire [31:0]signExtendOut;
  Sign_extend signExtend(signExtendOut,IMemOut[15:0]);

///ALU CONTROL
  wire[1:0]aluOp;
  wire[2:0]aluControl3bit;
  alucontrol aluController(aluOp, IMemOut[5:0], aluControl3bit);

//POST-REGISTER MUX
  wire aluSrc;
  wire [31:0]aluSecondInput;
  mux postRegisterMux(readData2,signExtendOut, aluSrc, aluSecondInput);

//ALU
  wire [31:0]aluOut;
  wire aluZero;
  alu mainALU(clk, readData1, aluSecondInput,aluControl3bit, aluOut, aluZero);
  
//DATA MEMORY
  wire [31:0]dataMemOut;
  wire dataMemWriteEnable, dataMemReadEnable;
  dataMemory dataMem(clk, aluOut, readData2, dataMemOut, dataMemWriteEnable,dataMemReadEnable);

//POST DATA MEMORY MUX
  //regWriteData defined at line 27.
  wire memToReg;
  mux dataMemMux(aluOut, dataMemOut,  memToReg, regWriteData);

//PC + 4 adder
  //PCOut defined at line 16.
  reg [31:0] change;
  initial change = 1;
  wire [31:0] PCplusFour;
  syncAdder PCPlusFourAdder(clk, PCOut, change, PCplusFour);

//Branch left shift
  wire[31:0] branchaddress;
  leftshift branchleftshift(branchaddress,signExtendOut);

//branch address adder
  wire[31:0] branchpc;
  adder branchAddressAdder(branchaddress,PCplusFour,branchpc);

//branch mux
  wire branchAndZero;
  wire branchEnable;
  and (branchAndZero, branchEnable, aluZero);
  wire [31:0]branchMuxOut;
  mux branchMux(PCplusFour, branchpc, branchAndZero, branchMuxOut);

//jump mux
  wire [31:0]jumpAddress;
  assign jumpAddress[31:28] = PCplusFour[31:28];
  assign jumpAddress[27:0] = IMemOut[25:0];//<<2;
  wire jumpEnable;
  mux jumpMux(branchMuxOut, jumpAddress, jumpEnable, PCIn);

//CONTROL UNIT
  control controlUnit(clk, IMemOut[31:26], regDst, jumpEnable, branchEnable, dataMemReadEnable, memToReg, aluOp, dataMemWriteEnable, aluSrc, regWriteEnable, PCEnable);

  initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, main);
    #200000 $finish;
  end
endmodule
