`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 09:35:45 PM
// Design Name: 
// Module Name: Processor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Processor(input clk, reset, ssd_clk, input[1:0] ledSel, input[3:0] ssdSel, output reg[15:0] LEDs, output [3:0] Anode,
 output [6:0] LED_out);
 wire [31:0] instruction;
 wire [31:0] PC, PC_plus_imm, PC_plus_4, next_PC;
 wire branch, memRead, memWrite, ALUSrc, regWrite, unsignedFlag ;
 wire [2:0] memToReg;
 wire [2:0] memOffset;
 wire [1:0] PC_mux;
 wire [1:0]  ALUOp;
 wire [31:0] write_data, read_data1, read_data2, ALU_input2;
 wire [31:0] Immediate;
 wire [3:0] ALUSelection;
 wire [31:0] ALUOutput;
 wire ZF, CF, VF, SF;
 wire [31:0] mem_data_out;
 reg [12:0] ssdOut;
 
 InstMem inst(.addr(PC), .data_out(instruction));
 control_unit cu(instruction[6:0], branch, memRead, memToReg, memWrite, ALUSrc, regWrite, ALUOp, memOffset, unsignedFlag, PC_mux);
 
 
 
endmodule
