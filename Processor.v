module Processor(input clk, reset, ssd_clk, input[1:0] ledSel, input[3:0] ssdSel, output reg[15:0] LEDs, output [3:0] Anode,
 output [6:0] LED_out);
 wire [31:0] instruction;
 wire [31:0] PC, PC_plus_imm, PC_plus_4, next_PC;
 wire branch, memRead, memWrite, ALUSrc, regWrite, unsignedFlag ;
 wire [2:0] memToReg;
 wire [2:0] memOffset;
 wire [1:0] PC_mux;
 wire [1:0]  ALUOp;
 wire [31:0] write_data, read_data1, read_data2, ALU_input2;
 wire [31:0] Immediate;
 wire [3:0] ALUSelection;
 wire [31:0] ALUOutput;
 wire cf, zf, vf, sf;
 wire [31:0] mem_data_out;
 reg [12:0] ssdOut;
 wire branch_signal;
 
 // PC +4 adder
 assign PC_plus_4 = PC + 4;
 assign PC_plus_imm = PC + Immediate;
 
 InstMem inst(.addr(PC), .data_out(instruction));
 control_unit cu(instruction[6:0], branch, memRead, memToReg, memWrite, ALUSrc, regWrite, ALUOp, memOffset, unsignedFlag, PC_mux);
 RegFile RF(clk, reset, instruction[19:15], instruction[24:20], instruction[11:7], write_data, regWrite, read_data1, read_data2);
 rv32_ImmGen IG(instruction, Immediate);
 n_bit_mux mux1(read_data2, Immediate, ALUSrc, ALU_input2);
 ALU_control_unit ALUCU(ALUOp, instruction[14:12], instruction[30], ALUSelection);
 prv32_ALU ALU(a.(read_data1), b.(ALU_input2), r.(ALUOutput), cf.(cf), zf.(zf), vf.(vf), sf.(sf), alufn.(ALUSelection));
 DataMem DM(clk, memRead, memWrite, memOffset, unsignedFlag, ALUOutput, read_data2, mem_data_out);
 rd_mux rd_input_data(ALUOutput, mem_data_out, PC_plus_4, Immediate, PC_plus_imm, memToReg, write_data);
 branch_control bc(instruction[14:12], zf, cf, vf, sf, branch_signal);
 PC_mux nextPC(PC_plus_4, PC_plus_imm, ALUOutput, branch&branch_signal, PC_mux, next_PC);
 n_bit_reg_file regPC(clk, reset, 1'b1, next_PC , PC);
 
 

 
endmodule
