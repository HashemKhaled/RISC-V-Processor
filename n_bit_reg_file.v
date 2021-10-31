`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 09:34:36 PM
// Design Name: 
// Module Name: n_bit_reg_file
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


module n_bit_reg_file #(parameter n = 8)(input clk, input rst, input load, input[n-1: 0]D, output [n-1: 0]Q );

wire [n-1:0] Y;
genvar i;
    generate
        for(i=0; i<n ; i= i+1) begin: HB
            mux m(Q[i], D[i], load, Y[i]);
            DFlipFlop ff(clk, rst, Y[i], Q[i]);
        end
    endgenerate
endmodule