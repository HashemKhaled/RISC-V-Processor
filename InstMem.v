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

initial begin
// lw x1 0(x0)
mem[0] = 8'h83;
mem[1] = 8'h20;
mem[2] = 8'h00;
mem[3] = 8'h00;

// lw x2 4(x0)
mem[4] = 8'h03;
mem[5] = 8'h21;
mem[6] = 8'h40;
mem[7] = 8'h00;

// addi x3 x1 260
mem[8] = 8'h93;
mem[9] = 8'h81;
mem[10] = 8'h40;
mem[11] = 8'h10;

// sb x3 8(x0)
mem[12] = 8'h23;
mem[13] = 8'h04;
mem[14] = 8'h30;
mem[15] = 8'h00;

// ecall
mem[16] = 8'h73;
mem[17] = 8'h00;
mem[18] = 8'h00;
mem[19] = 8'h00;
end 
endmodule
