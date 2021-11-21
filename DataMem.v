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
 (input clk, input rst, input MemRead, input MemWrite, input [2:0] memOffset, input unsignedFlag
 , input [31:0] addr, input [31:0] data_in, output reg [31:0] out);
 reg [7:0] mem [300:0];
 wire[31:0] mem_addr; 
 assign mem_addr = addr + 200; // 50 instructions
 reg [31:0]  inst_out;
 reg [31:0]  data_out;
 
 always @(*)
 begin 
 if (clk)
 out=inst_out;
 else 
 out=data_out;
 end 
 
 
 always@(*) begin
    if(MemRead) begin
        if(memOffset == 3'b100) begin
            data_out[7:0] = mem[mem_addr];
            data_out[15:8] = mem[mem_addr+1];
            data_out[23:16] = mem[mem_addr+2];
            data_out[31:24] = mem[mem_addr+3];
        end
        else if(memOffset == 3'b010) begin
            data_out[7:0] = mem[mem_addr];
            data_out[15:8] = mem[mem_addr+1];
            if(unsignedFlag) data_out[31:16] = 16'b0;
            else data_out[31:16] = {16{data_out[15]}};
        end
        else if(memOffset == 3'b001) begin
            data_out[7:0] = mem[mem_addr];
            if(unsignedFlag) data_out[31:8] = 24'b0;
            else data_out[31:8] = {24{data_out[7]}};
        end
    end
    else data_out=0;
 end
 integer i;
 
 
 always@(posedge clk )begin
      if(~rst)begin
        if(MemWrite) begin
             if(memOffset == 3'b100) begin
                 mem[mem_addr] = data_in[7:0];
                 mem[mem_addr+1] = data_in[15:8];
                 mem[mem_addr+2] = data_in[23:16];
                 mem[mem_addr+3] = data_in[31:24];
             end
             else if(memOffset == 3'b010) begin
                 mem[mem_addr] = data_in[7:0];
                 mem[mem_addr+1] = data_in[15:8];
             end
             else if(memOffset == 3'b001) begin
                 mem[mem_addr] = data_in[7:0];
             end
         end
     end
 end
 
endmodule
