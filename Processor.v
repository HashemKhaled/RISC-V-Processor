`include "defines.v"
module Processor(input clk, reset);
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
 control_unit cu(instruction[6:0], instruction[`IR_funct3], branch, memRead, memToReg, memWrite, ALUSrc, regWrite, ALUOp, memOffset, unsignedFlag, PC_mux);
 RegFile RF(clk, reset, instruction[19:15], instruction[24:20], instruction[11:7], write_data, regWrite, read_data1, read_data2);
 rv32_ImmGen IG(instruction, Immediate);
 n_bit_mux mux1(read_data2, Immediate, ALUSrc, ALU_input2);
 ALU_control_unit ALUCU(ALUOp, instruction[14:12], instruction[30], ALUSelection);
 prv32_ALU ALU(.a(read_data1), .b(ALU_input2), .r(ALUOutput), .cf(cf), .zf(zf), .vf(vf), .sf(sf), .alufn(ALUSelection));
 DataMem DM(clk, reset, memRead, memWrite, memOffset, unsignedFlag, ALUOutput, read_data2, mem_data_out);
 rd_mux rd_input_data(ALUOutput, mem_data_out, PC_plus_4, Immediate, PC_plus_imm, memToReg, write_data);
 branch_control bc(instruction[14:12], zf, cf, vf, sf, branch_signal);
 PC_mux nextPC(reset, PC_plus_4, PC_plus_imm, ALUOutput, branch&branch_signal, PC_mux, next_PC);
 n_bit_reg_file regPC(clk, reset, 1'b1, next_PC , PC);
 
 /*
always @(*) begin
    if(ledSel == 2'b00)
        LEDs = instruction [15:0];
    else if (ledSel == 2'b01)
        LEDs = instruction [31:16];
    else if (ledSel == 2'b10)
        LEDs = {8'b00000000, ALUOp, ALUSelection, zeroFlag, zeroFlag&branch};
    else
        LEDs = 0;
    end    

always @(*) begin
    if(ssdSel == 4'b0000)
        ssdOut = PC;
    else if(ssdSel == 4'b0001)
        ssdOut = PC + 1;
    else if(ssdSel == 4'b0010)
        ssdOut = PC_target;
    else if(ssdSel == 4'b0011)
        ssdOut = next_pc;
    else if(ssdSel == 4'b0100)
        ssdOut = read_data1;
    else if(ssdSel == 4'b0101)
        ssdOut = read_data2;
    else if(ssdSel == 4'b0110)
        ssdOut = write_data;
    else if(ssdSel == 4'b0111)
        ssdOut = Immediate;
    else if(ssdSel == 4'b1000)
        ssdOut = Immediate*2;
    else if(ssdSel == 4'b1001)
        ssdOut = ALU_input2;
    else if(ssdSel == 4'b1010)
        ssdOut = ALUOutput;
    else if(ssdSel == 4'b1011)
        ssdOut = mem_data_out;
end

Four_Digit_Seven_Segment_Driver four_Digit_Seven_Segment_Driver(ssd_clk, ssdOut, Anode, LED_out);
 */
endmodule
