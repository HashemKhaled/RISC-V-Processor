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
        else if(memOffset == 3'b010) begin
            data_out[7:0] = mem[addr];
            data_out[15:8] = mem[addr+1];
            if(unsignedFlag) data_out[31:16] = 16'b0;
            else data_out[31:16] = {16{data_out[15]}};
        end
        else if(memOffset == 3'b001) begin
            data_out[7:0] = mem[addr];
            if(unsignedFlag) data_out[31:16] = 24'b0;
            else data_out[31:16] = {24{data_out[7]}};
        end
    end
 end
 always@(*)begin
    if(MemWrite) begin
         if(memOffset == 3'b100) begin
             mem[addr] = data_in[7:0];
             mem[addr+1] = data_in[15:8];
             mem[addr+2] = data_in[23:16];
             mem[addr+3] = data_in[31:24];
         end
         else if(memOffset == 3'b010) begin
             mem[addr] = data_in[7:0];
             mem[addr+1] = data_in[15:8];
         end
         else if(memOffset == 3'b001) begin
             mem[addr] = data_in[7:0];
         end
     end
 end
 
 
  
  
  // Data Mem intiilization for experiment 2
  
  initial begin
  // mem[0-3] = 100
    mem[0] = 8'h64;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h00;
    
  // mem[4-7] = 200
    mem[4] = 8'hC8;
    mem[5] = 8'h00;
    mem[6] = 8'h00;
    mem[7] = 8'h00;   
  end
  
  
endmodule
