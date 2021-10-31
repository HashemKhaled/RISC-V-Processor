`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 08:25:27 PM
// Design Name: 
// Module Name: InstMem
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


module InstMem (input [31:0] addr, output [31:0] data_out);

reg [7:0] mem [(4*1024-1):0];
assign data_out[7:0] = mem[addr];
assign data_out[15:8] = mem[addr+1];
assign data_out[23:16] = mem[addr+2];
assign data_out[31:24] = mem[addr+3];
 
endmodule
