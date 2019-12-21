/*
  * @author: all
  * THIS MIPS ARCHITECTURE SUPPORTS THE FOLLOWING:
  * ADD
  * SUB
  * ADDI
  * LW
  * SW
  * AND
  * OR
  * BEQ
  * SLT
J
*/
module control(clk, opcode, regdst, jump, branch, memread, memtoreg, aluop, memwrite, alusrc, regwrite, pcupdate);

input clk;
input [5:0]opcode;
output reg regdst, branch, jump, memread, memtoreg, memwrite, alusrc, regwrite, pcupdate;
output reg [1:0]aluop;



integer counter;

initial begin
  counter = 0;
  pcupdate = 0;
  jump = 0;
  branch = 0;
  aluop = 3;
  alusrc = 0;
  memread = 0;
  memwrite = 0;
  memtoreg = 0;
  regwrite = 0;
  regdst = 0;
end


always @(posedge clk)
begin
  pcupdate = 0;
  counter = (counter+1)%5;
  if(counter == 0) // INSTRUCTION DECODE STAGE ////////////////////////////////
  begin
    pcupdate = 0;
    aluop = 0;
    case(opcode)
      6'b000000 : aluop = 2; // R-FORMAT has wb
      6'b001000: alusrc = 1; //ADDI has wb
      6'b100011: alusrc = 1; //LW has wb
      6'b101011:
      begin
        aluop = 0;
        alusrc = 1;
      end //SW no
      6'b000100: //BEQ no
      begin
        branch = 1;
        aluop = 1;
      end
      6'b000010 : jump = 1; // JUMP no
      6'b111111: $finish;
    endcase
  end
    ///////END OF INSTRUCTION DECODE STAGE////////////////////////////////////
    //////REGISTER ACCESS STAGE//////////////////////////////////////////////
  else if(counter == 2)
  begin
    memread = 0;
    memwrite = 0;
    //memread and memwrite
    case(opcode)
      6'b100011: memread = 1;
      6'b101011: memwrite = 1;
    endcase
  end
    //END OF REGISTER ACCESS STAGE////////////////////////////////////////////
    //WRITEBACK STAGE////////////////////////////////////////////////////////
  else if(counter == 3)
  begin
    regwrite = 0;
    memtoreg = 0;
    regdst = 0;
    //regwrite,memtoreg, regdst
    case(opcode)
      6'b000000: //RFORMAT
      begin
        regwrite = 1;
        regdst = 1;
      end
      6'b001000: regwrite = 1; //ADDI
      6'b100011:
      begin
        regwrite = 1; //LW
        memtoreg = 1;
      end
    endcase
  end

    ///////END OF WRITEBACK STAGE////////////////////////////////////
    ///////PC UPDATE STAGE//////////////////////////////////////////
  else if(counter == 4)
  begin
    pcupdate = 1;
    jump = 0;
    branch = 0;
    aluop = 3;
    alusrc = 0;
    memread = 0;
    memwrite = 0;
    memtoreg = 0;
    regwrite = 0;
    regdst = 0;
  end
end
endmodule
