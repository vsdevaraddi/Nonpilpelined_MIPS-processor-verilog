/*
    * @author: Shubhayu Das
    * This is the program counter code
    * Simply takes in a memory location value and gives it out when output is enabled
    * Output enable is required because it's non-pipelined architecture here
*/

module PC(clk, memLoc, outputEnable, currentPointer);
    input outputEnable, clk;
    input [31:0]memLoc;
    output reg[31:0] currentPointer;

    initial currentPointer = 0;

    always@(posedge outputEnable) begin
        if(outputEnable)
            currentPointer = memLoc;

    end
endmodule
