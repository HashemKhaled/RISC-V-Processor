// file: control_unit.v
// author: @hashoom

`timescale 1ns/1ns
`include "defines.v"

module control_unit(input [6:0] inst, input[2:0] funct3, output reg branch, output reg memRead, output reg[2:0] memToReg, output reg memWrite, output reg ALUSrc, output reg regWrite, output reg [1:0]  ALUOp, output reg[2:0] memOffset, output reg unsignedFlag, output reg[1:0] PC_mux);

always@(*) begin
    if(inst == 7'b0110111) begin  // LUI
        branch = 1'b0;
        memRead = 1'b0;
        memToReg = 3'b011;
        memWrite = 1'b0;
        ALUSrc = 1'b0;
        regWrite = 1'b1;
        ALUOp = 2'b00;
        memOffset = 3'b000;
        unsignedFlag = 1'b0;
	PC_mux = 2'b00;
    end
    else if(inst == 7'b0010111) begin  // AUIPC
        branch = 1'b0;
        memRead = 1'b0;
        memToReg = 3'b100;
        memWrite = 1'b0;
        ALUSrc = 1'b0;
        regWrite = 1'b1;
        ALUOp = 2'b00;
        memOffset = 3'b000;
        unsignedFlag = 1'b0;
	PC_mux = 2'b00;
    end
    else if(inst == 7'b1101111) begin // JAL
        branch = 1'b0;
        memRead = 1'b0;
        memToReg = 3'b010;
        memWrite = 1'b0;
        ALUSrc = 1'b0;
        regWrite = 1'b1;
        ALUOp = 2'b00;
        memOffset = 3'b000;
        unsignedFlag = 1'b0;
	PC_mux = 2'b01;
    end
    else if(inst == 7'b1100111) begin // JALR
        branch = 1'b0;
        memRead = 1'b0;
        memToReg = 3'b010;
        memWrite = 1'b0;
        ALUSrc = 1'b1;
        regWrite = 1'b1;
        ALUOp = 2'b00;
        memOffset = 3'b000;
        unsignedFlag = 1'b0;
	PC_mux = 2'b10;
    end
    else if(inst == 7'b1100011) begin // B-type
        branch = 1'b1;
        memRead = 1'b0;
        memToReg = 3'b000;
        memWrite = 1'b0;
        ALUSrc = 1'b0;
        regWrite = 1'b0;
        ALUOp = 2'b11;
        memOffset = 3'b000;
        unsignedFlag = 1'b0;
	PC_mux = 2'b11;
    end
    else if(inst == 7'b0010011) begin // I-type
        branch = 1'b0;
        memRead = 1'b0;
        memToReg = 3'b000;
        memWrite = 1'b0;
        ALUSrc = 1'b1;
        regWrite = 1'b1;
        ALUOp = 2'b01;
        memOffset = 3'b000;
        unsignedFlag = 1'b0;
	PC_mux = 2'b00;
    end
    else if(inst == 7'b0110011) begin // R-type
        branch = 1'b0;
        memRead = 1'b0;
        memToReg = 3'b000;
        memWrite = 1'b0;
        ALUSrc = 1'b0;
        regWrite = 1'b1;
        ALUOp = 2'b10;
        memOffset = 3'b000;
        unsignedFlag = 1'b0;
	PC_mux = 2'b00;
    end
    else if(inst == 7'b0000011) begin // load
        branch = 1'b0;
        memRead = 1'b1;
        memToReg = 3'b001;
        memWrite = 1'b0;
        ALUSrc = 1'b1;
        regWrite = 1'b1;
        ALUOp = 2'b00;
	PC_mux = 2'b00;
	if(inst[`IR_funct3] == 3'b000) begin
        	memOffset = 3'b001;
        	unsignedFlag = 1'b0;
	end
	else if(inst[`IR_funct3] == 3'b001) begin
		memOffset = 3'b010;
        	unsignedFlag = 1'b0;
	end
	else if(inst[`IR_funct3] == 3'b010) begin
		memOffset = 3'b100;
        	unsignedFlag = 1'b0;
	end
	else if(inst[`IR_funct3] == 3'b100) begin
		memOffset = 3'b001;
        	unsignedFlag = 1'b1;
	end
	else if(inst[`IR_funct3] == 3'b101) begin
		memOffset = 3'b010;
        	unsignedFlag = 1'b1;
	end
    end
    else if(inst == 7'b0100011) begin // store
        branch = 1'b0;
        memRead = 1'b0;
        memToReg = 3'b000;
        memWrite = 1'b01;
        ALUSrc = 1'b1;
        regWrite = 1'b0;
        ALUOp = 2'b00;
	PC_mux = 2'b00;
	unsignedFlag = 1'b0;
	if(inst[`IR_funct3] == 3'b000) begin
        	memOffset = 3'b001;
	end
	else if(inst[`IR_funct3] == 3'b001) begin
		memOffset = 3'b010;
	end
	else if(inst[`IR_funct3] == 3'b010) begin
		memOffset = 3'b100;
	end
    end 
end

endmodule
