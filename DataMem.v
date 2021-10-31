`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 08:26:33 PM
// Design Name: 
// Module Name: DataMem
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


module DataMem
 (input clk, input MemRead, input MemWrite, input [2:0] memOffset, input unsignedFlag
 , input [31:0] addr, input [31:0] data_in, output reg [31:0] data_out);
 reg [7:0] mem [(4*1024-1):0];
 
 always@(*) begin
    if(MemRead) begin
        if(memOffset == 3'b100) begin
            data_out[7:0] = mem[addr];
            data_out[15:8] = mem[addr+1];
            data_out[23:16] = mem[addr+2];
            data_out[31:24] = mem[addr+3];
        end
        if(memOffset == 3'b010) begin
            data_out[7:0] = mem[addr];
            data_out[15:8] = mem[addr+1];
            if(unsignedFlag) data_out[31:16] = 16'b0;
            else data_out[31:16] = {16{data_out[15]}};
        end
    end
        if(memOffset == 3'b010) begin
            data_out[7:0] = mem[addr];
            if(unsignedFlag) data_out[31:16] = 24'b0;
            else data_out[31:16] = {24{data_out[7]}};
        end
 end
 always@(posedge clk)begin
    if(MemWrite) begin
         if(memOffset == 3'b100) begin
             mem[addr] = data_in[7:0];
             mem[addr+1] = data_in[15:8];
             mem[addr+2] = data_in[23:16];
             mem[addr+3] = data_in[31:24];
         end
         if(memOffset == 3'b010) begin
             mem[addr] = data_in[7:0];
             mem[addr+1] = data_in[15:8];
         end
     end
         if(memOffset == 3'b010) begin
             mem[addr] = data_in[7:0];
         end
 end
 
 
  
  
  // Data Mem intiilization for experiment 2
  /*
  initial begin
    mem[0]=32'd10;
    mem[1]=32'd7; 
    mem[2]=32'd1;
    end
  */
  
endmodule
