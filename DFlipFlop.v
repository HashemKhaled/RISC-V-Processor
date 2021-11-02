// file: DFlipFlop.v
// author: @hashoom

`timescale 1ns/1ns

module DFlipFlop
 (input clk, input rst, input D, output reg Q);
 always @ (posedge clk or posedge rst)
 if (rst) begin
 Q <= 1'b0;
 end 
 else begin
 Q <= D;
 end
endmodule 
