`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 08:48:25 PM
// Design Name: 
// Module Name: PC_mux
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


module PC_mux_module(input rst, input [31:0]PC_plus_4, [31:0]PC_plus_imm, [31:0]ALUOutput, input AND_gate_output, [1:0]PC_mux_signal, output reg [31:0]next_PC);
always@(*) begin
  if(rst) next_PC = 0;
  else begin
  case(PC_mux_signal)
    2'b00: next_PC = PC_plus_4;
    2'b01: next_PC = PC_plus_imm;
    2'b10: next_PC = ALUOutput;
    2'b11: next_PC = AND_gate_output? PC_plus_imm :PC_plus_4;
    default:next_PC=0;
  endcase
  end
end
endmodule

