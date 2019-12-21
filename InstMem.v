/*
    *  @author   Shubhayu Das
    *  Override the parameters by pasting these into the test bench
    *  defparam uut.BASE_ADDR = 31'b1;
    *  defparam uut.MEM_SIZE = 50;
    *  Base address can be defined as per need;
    *  I will add BASE_ADDR to the relative input address. input address range: [0,MEM_SIZE-1]
*/

module InstMem#(parameter BASE_ADDR = 31'b0,parameter MEM_SIZE = 17)(clk, address, instruction);
    input clk;
    input[31:0] address;
    output reg[31:0] instruction;

    reg [31:0]InstructionMemory [0:MEM_SIZE];

    initial $readmemb("./fact.dat", InstructionMemory);

    always@(address) begin
        instruction = InstructionMemory[address+BASE_ADDR];
        if(address > MEM_SIZE) $finish;
    end

endmodule

// module tb();
//     reg clk;
//     reg [31:0] address;
//     wire[31:0] instruction;

//     InstMem uut(clk, address, instruction);

//     initial begin
//         clk = 0;
//         $dumpfile("inst.vcd");
//         $dumpvars(0, tb);

//         address = 32'b0;
//             #10;
//         address = 32'b1;
//         #10;
//         address = 32'b10;
//         #10;
//         address = 32'b11;
//         #10;
//         address = 32'b100;
//         #10;
//         address = 32'b101;
//         #10;
//         address = 32'b110;
//         #10;
//         address = 32'b111;
//         #10;
//         $finish;
//     end

//     always #5 clk = ~clk;

// endmodule
