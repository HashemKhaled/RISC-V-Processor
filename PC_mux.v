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


module PC_mux(input [31:0]PC_plus_4, [31:0]PC_plus_imm, [31:0]ALUOutput, [31:0]AND_gate_output, [1:0]PC_mux_signal, output reg [31:0]next_PC);
always@(*) begin
  case(PC_mux_signal)
    2'b00: next_PC = PC_plus_4;
    2'b01: next_PC = PC_plus_imm;
    2'b10: next_PC = ALUOutput;
    2'b11: next_PC = AND_gate_output;
  endcase
end
endmodule
