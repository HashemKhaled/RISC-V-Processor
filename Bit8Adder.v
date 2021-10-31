`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 09:29:14 PM
// Design Name: 
// Module Name: Bit8Adder
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


module Bit8Adder(input clk, input [31:0] a, b, output [31:0]sum);
    wire[32:0] c;
    wire cout;
    wire [31:0] s;
    assign c[0] = 0;
    assign cout = c[32];
    genvar i;
    generate
        for(i=0; i<32 ; i= i+1) begin: HB
            fullAdder f(.a(a[i]), .b(b[i]), .cin(c[i]), .s(s[i]), .cout(c[i+1]));
        end
    endgenerate
   assign sum = s;
endmodule
