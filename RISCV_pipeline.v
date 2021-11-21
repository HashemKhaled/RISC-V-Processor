`include "defines.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2021 07:25:28 PM
// Design Name: 
// Module Name: RISCV_pipeline
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

//Testing by simulation
//module RISCV_pipeline(input clk, reset);
//Testing by FPGA
module RISCV_pipeline (input clk, reset, ssd_clk, input[1:0] ledSel, input[3:0] ssdSel, output reg[15:0] LEDs, output [3:0] Anode,
 output [6:0] LED_out);


//All stages Wires
reg [31:0] mem_in;
wire  [31:0]mem_out;

// IF Stage
wire [31:0] PC;
reg [31:0] initial_IR;
wire [31:0] PC_plus_imm, next_PC, PC_plus4;
wire [31:0] IF_ID_PC, IF_ID_Inst;
wire[31:0] IR;
wire compressed;
assign PC_plus4 = compressed? PC + 2: PC + 4;
// ID Stage
// control unit wires
wire branch, memRead, memWrite, ALUSrc, regWrite, unsignedFlag ;
wire [2:0] memToReg;
wire [2:0] memOffset;
wire [1:0] PC_mux;
wire [1:0]  ALUOp;
wire [3:0] WB = {memToReg,regWrite}; // 4 bits --> memToReg = WB[3:1], regWrite = WB[0]
wire [5:0] M = {memOffset , unsignedFlag , memRead, memWrite}; //6 bits --> memOffset = M[5:3],  unsignedFlag = M[2], memRead = M[1], memWrite = M[0]
wire [2:0] EX = {ALUSrc, ALUOp}; // 3 bits --> ALUSrc = EX[2], ALUOp = EX[1:0]

// Register file wires
wire [31:0] read_data1, read_data2;
// Immidiate wires
wire [31:0] Immediate;
// ID/EX Register Wires
wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
wire [15:0] ID_EX_Ctrl, ID_EX_sel_ctrl; //{branch, PC_mux, EX, M, WB} 
wire [4:0] ID_EX_Func; // ID_EX_Func = {IF_ID_Inst[25], IF_ID_Inst[14:12], IF_ID_Inst[30]}
wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd;

//Ex Stage
wire [31:0] ALU_input2; 
wire [4:0] ALUSelection;
wire [31:0] ALUOutput;
wire cf, zf, vf, sf;

//EX/MEM Resgiter Wires
wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_PC, EX_MEM_PC_target, EX_MEM_Imm;
wire [12:0] EX_MEM_Ctrl; // {branch, PC_mux, M, WB}
wire [4:0] EX_MEM_Rd;
wire [2:0] EX_MEM_func3;
wire EX_MEM_CF,  EX_MEM_VF,  EX_MEM_SF, EX_MEM_Zero;

// MEM wires
 reg [31:0] mem_data_out;
 wire branch_signal;
 //MEM/WB Resgiter Wires
 wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_PC, MEM_WB_PC_target, MEM_WB_Imm;
 wire [4:0] MEM_WB_Rd;
 wire [7:0] MEM_WB_Ctrl; //{branch, branch_signal, PC_mux, WB}
 
//WB Wires
wire [31:0] write_data;

//forwarding wires
wire forwardA;
wire forwardB;
wire [31:0] forwardA_mux_output; 
wire [31:0] forwardB_mux_output; 

// Flushing
wire flush;

// slow clock
reg slow_clk=0;
always@(posedge clk, posedge reset)begin
 slow_clk <= ~slow_clk;
 if(reset)
 slow_clk = 0;
end

// IF/ID Stage


// ID_EX

control_unit cu(IF_ID_Inst[6:0], IF_ID_Inst[`IR_funct3], branch, memRead, memToReg, memWrite, ALUSrc, regWrite, ALUOp, memOffset, unsignedFlag, PC_mux);
RegFile RF(clk, reset, IF_ID_Inst[19:15], IF_ID_Inst[24:20],MEM_WB_Rd, write_data, MEM_WB_Ctrl[0], read_data1, read_data2);
rv32_ImmGen IG(IF_ID_Inst, Immediate); 


forwarding_unit FU(ID_EX_Rs1, ID_EX_Rs2, MEM_WB_Rd, MEM_WB_Ctrl[0]  ,forwardA, forwardB);
n_bit_mux MFA(ID_EX_RegR1, write_data, forwardA, forwardA_mux_output);
n_bit_mux MFB(ID_EX_RegR2, write_data, forwardB, forwardB_mux_output);
//ID/EX Register
assign ID_EX_sel_ctrl = flush? 16'd0: {branch, PC_mux, EX, M, WB};
n_bit_reg_file #(164) ID_EX (slow_clk,reset,1'b1,
{ID_EX_sel_ctrl, IF_ID_PC, read_data1, read_data2, Immediate, IF_ID_Inst[25], IF_ID_Inst[14:12], IF_ID_Inst[30], IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7]},

{ID_EX_Ctrl,ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2,
 ID_EX_Imm, ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd} );
// Rs1 and Rs2 are needed later for the forwarding unit

// EX Stage
n_bit_mux mux1(forwardB_mux_output, ID_EX_Imm, ID_EX_Ctrl[12], ALU_input2);
ALU_control_unit ALUCU(ID_EX_Ctrl[11:10], ID_EX_Func[3:1],ID_EX_Func[4], ID_EX_Func[0], ALUSelection);
prv32_ALU ALU(.a(forwardA_mux_output), .b(ALU_input2), .r(ALUOutput), .cf(cf), .zf(zf), .vf(vf), .sf(sf), .alufn(ALUSelection));
assign PC_plus_imm = ID_EX_PC + ID_EX_Imm;

//EX_MEM Register
n_bit_reg_file #(217) EX_MEM (~slow_clk,reset,1'b1,
 {ID_EX_Ctrl[15:13], ID_EX_Ctrl[9:0],  PC_plus_imm, cf, vf, sf, zf, ALUOutput, forwardB_mux_output,  ID_EX_Rd, ID_EX_Func[3:1], ID_EX_PC, PC_plus_imm, ID_EX_Imm },
 {EX_MEM_Ctrl, EX_MEM_BranchAddOut, EX_MEM_CF,  EX_MEM_VF,  EX_MEM_SF, EX_MEM_Zero, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd, EX_MEM_func3, EX_MEM_PC, EX_MEM_PC_target, EX_MEM_Imm} ); 
 //MEM stage
DataMem DM(slow_clk, reset, EX_MEM_Ctrl[5], EX_MEM_Ctrl[4], EX_MEM_Ctrl[9:7], EX_MEM_Ctrl[6],mem_in, EX_MEM_RegR2, mem_out);
branch_control bc(EX_MEM_func3, EX_MEM_Zero, EX_MEM_CF, EX_MEM_VF, EX_MEM_SF, branch_signal);
assign flush = (EX_MEM_Ctrl[12]&branch_signal) | (EX_MEM_Ctrl[11:10] == 2'b01) | (EX_MEM_Ctrl[11:10] == 2'b10);
PC_mux_module nextPC(reset,PC_plus4 , EX_MEM_PC_target, EX_MEM_ALU_out, EX_MEM_Ctrl[12]&branch_signal, EX_MEM_Ctrl[11:10], next_PC);

////MEM_WB Register
n_bit_reg_file #(173) MEM_WB (slow_clk,reset,1'b1,
{branch, branch_signal, EX_MEM_Ctrl[11:10], EX_MEM_Ctrl[3:0] , mem_data_out, EX_MEM_ALU_out, EX_MEM_Rd, EX_MEM_PC, EX_MEM_PC_target, EX_MEM_Imm},
 {MEM_WB_Ctrl, MEM_WB_Mem_out, MEM_WB_ALU_out,
 MEM_WB_Rd, MEM_WB_PC, MEM_WB_PC_target, MEM_WB_Imm});
 
 // Write Back Stage
 rd_mux rd_input_data(MEM_WB_ALU_out, MEM_WB_Mem_out, MEM_WB_PC+4, MEM_WB_Imm, MEM_WB_PC_target, MEM_WB_Ctrl[3:1], write_data);
 n_bit_reg_file regPC(slow_clk, reset, 1'b1, next_PC , PC); 
 
 

endmodule
