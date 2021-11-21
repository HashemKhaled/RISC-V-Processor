// file: Branch_control.v
// author: @basantelhussein

`timescale 1ns/1ns
`include "defines.v"

module branch_control(input [2:0] funct3, input zf, cf, vf, sf, output reg sig);
always@(*)begin
  if(funct3 == `BR_BEQ) sig = zf;
  else if(funct3 == `BR_BNE) sig = (!zf);
  else if(funct3 == `BR_BLT) sig = (sf != vf);
  else if(funct3 == `BR_BGE) sig = (sf == vf);
  else if(funct3 == `BR_BLTU) sig = (!cf);
  else if(funct3 == `BR_BGEU) sig = (cf);
  else sig = 0; // ECALL - EBREAK
end

endmodule
