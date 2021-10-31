`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 08:36:45 PM
// Design Name: 
// Module Name: rd_mux
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


module rd_mux(input [31:0]ALUOutput, [31:0]DataMemOutput, [31:0]PC_plus_4, [31:0]ImmGenOutput, [31:0]PC_plus_imm, [2:0]MemToReg, output reg [31:0] rd_write_data);

always@(*) begin
  case(MemToReg)
    3'b000: rd_write_data = ALUOutput;
    3'b001: rd_write_data = DataMemOutput;
    3'b010: rd_write_data = PC_plus_4;
    3'b011: rd_write_data = ImmGenOutput;
    3'b110: rd_write_data = PC_plus_imm;
  endcase
end

endmodule
