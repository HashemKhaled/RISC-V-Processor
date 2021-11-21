// file: ALU_control_unit.v
// author: @hashoom

`timescale 1ns/1ns
`include "defines.v"

module ALU_control_unit(input [1:0] ALUOp, input [2:0] funct3, input inst25, input inst30, output reg [4:0] ALUSelection);

always@(*) begin
  if(ALUOp == 2'b00) begin
    ALUSelection = 4'b0000;
  end
  else if(ALUOp == 2'b01) begin
    if(funct3 == 3'b000) ALUSelection = `ALU_ADD;
    else if(funct3 == 3'b010) ALUSelection = `ALU_SLT;
    else if(funct3 == 3'b011) ALUSelection = `ALU_SLTU;
    else if(funct3 == 3'b100) ALUSelection = `ALU_XOR;
    else if(funct3 == 3'b110) ALUSelection = `ALU_OR;
    else if(funct3 == 3'b111) ALUSelection = `ALU_AND;
    else if(funct3 == 3'b001) ALUSelection = `ALU_SLL;
    else if(funct3 == 3'b101 && inst30 == 1'b0) ALUSelection = `ALU_SRL;
    else if(funct3 == 3'b101 && inst30 == 1'b1) ALUSelection = `ALU_SRA;
    else ALUSelection = `ALU_PASS;
  end
  else if(ALUOp == 2'b10) begin
      //M Extenstion
      if(inst25) begin
        if(funct3 ==  3'b000)  ALUSelection = `ALU_MUL;
        else if(funct3 == 3'b001) ALUSelection = `ALU_MULH;
        else if(funct3 == 3'b010) ALUSelection = `ALU_MULHSU;
        else if(funct3 == 3'b011) ALUSelection = `ALU_MULHU;
        else if(funct3 == 3'b100) ALUSelection = `ALU_DIV;
        else if(funct3 == 3'b101) ALUSelection = `ALU_DIVU;
        else if(funct3 == 3'b110) ALUSelection = `ALU_REM;
        else if(funct3 == 3'b111) ALUSelection = `ALU_REMU;
      end
      else begin
        if(funct3 == 3'b000 && inst30 == 0) ALUSelection = `ALU_ADD;
        else if(funct3 == 3'b000 && inst30 == 1) ALUSelection = `ALU_SUB;
        else if(funct3 == 3'b001) ALUSelection = `ALU_SLL;
        else if(funct3 == 3'b010) ALUSelection = `ALU_SLT;
        else if(funct3 == 3'b011) ALUSelection = `ALU_SLTU;
        else if(funct3 == 3'b100) ALUSelection = `ALU_XOR;
        else if(funct3 == 3'b101 && inst30 == 1'b0) ALUSelection = `ALU_SRL;
        else if(funct3 == 3'b101 && inst30 == 1'b1) ALUSelection = `ALU_SRA;
        else if(funct3 == 3'b110) ALUSelection = `ALU_OR;
        else if(funct3 == 3'b111) ALUSelection = `ALU_AND; 
     end  
  end
   else begin
    ALUSelection = `ALU_SUB;
   end
end

endmodule
