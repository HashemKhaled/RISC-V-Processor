`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 04:03:31 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(input [4:0] ID_EX_Rs1, [4:0]ID_EX_Rs2, [4:0]MEM_WB_Rd, input MEM_WB_RegWrite, output reg forwardA, output reg forwardB);

always@(*) begin
 
    if ( (MEM_WB_RegWrite ) && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs1) )
            forwardA = 1'b1;
            else forwardA = 0;
            
     if ( (MEM_WB_RegWrite ) && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs2) )
            forwardB = 1'b1;
    else 
        forwardB = 0;
    end

endmodule
