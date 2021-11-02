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

// comprehensive test case:
initial begin


{mem[3],mem[2],mem[1],mem[0]}=32'h00013137;
{mem[7],mem[6],mem[5],mem[4]}=32'h00015197;
{mem[11],mem[10],mem[9],mem[8]}=32'h00310133;
{mem[15],mem[14],mem[13],mem[12]}=32'h00310463;
{mem[19],mem[18],mem[17],mem[16]}=32'h00311463;
{mem[23],mem[22],mem[21],mem[20]}=32'h002181b3;
{mem[27],mem[26],mem[25],mem[24]}=32'h00002083;
{mem[31],mem[30],mem[29],mem[28]}=32'h401101b3;
{mem[35],mem[34],mem[33],mem[32]}=32'h4021d193;
{mem[39],mem[38],mem[37],mem[36]}=32'h00119193;
{mem[43],mem[42],mem[41],mem[40]}=32'h0021d193;
{mem[47],mem[46],mem[45],mem[44]}=32'h0011d463;
{mem[51],mem[50],mem[49],mem[48]}=32'h00819193;
{mem[55],mem[54],mem[53],mem[52]}=32'h00201083;
{mem[59],mem[58],mem[57],mem[56]}=32'h00400103;
{mem[63],mem[62],mem[61],mem[60]}=32'h00404183;
{mem[67],mem[66],mem[65],mem[64]}=32'h0020e463;
{mem[71],mem[70],mem[69],mem[68]}=32'h00210133;
{mem[75],mem[74],mem[73],mem[72]}=32'h00a00393;
{mem[79],mem[78],mem[77],mem[76]}=32'h0023f433;
{mem[83],mem[82],mem[81],mem[80]}=32'h0023e4b3;
{mem[87],mem[86],mem[85],mem[84]}=32'h01617493;
{mem[91],mem[90],mem[89],mem[88]}=32'h0080056f;
{mem[95],mem[94],mem[93],mem[92]}=32'h00000073;
{mem[99],mem[98],mem[97],mem[96]}=32'hfff4b313;
{mem[103],mem[102],mem[101],mem[100]}=32'h00050067;



end

/*
initial begin
// lui x1, 260524
mem[0] = 8'hb7;
mem[1] = 8'hc0;
mem[2] = 8'h9a;
mem[3] = 8'h3f;

// sw x1, 0(x0)
mem[4] = 8'h23;
mem[5] = 8'h20;
mem[6] = 8'h10;
mem[7] = 8'h00;


// lw x2, 0(x0)
mem[8] = 8'h03;
mem[9] = 8'h21;
mem[10] = 8'h00;
mem[11] = 8'h00;

// lh x3, 0(x0)
mem[12] = 8'h83;
mem[13] = 8'h11;
mem[14] = 8'h00;
mem[15] = 8'h00;

// lhu x4, 0(x0)
mem[16] = 8'h03;
mem[17] = 8'h52;
mem[18] = 8'h00;
mem[19] = 8'h00;

// lb x5, 2(x0)
mem[20] = 8'h83;
mem[21] = 8'h02;
mem[22] = 8'h20;
mem[23] = 8'h00;

// lbu x6, 2(x0)
mem[24] = 8'h03;
mem[25] = 8'h43;
mem[26] = 8'h20;
mem[27] = 8'h00;
end 
*/
/*initial begin
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
end */
endmodule
