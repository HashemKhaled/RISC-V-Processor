`include "defines.v"
module prv32_ALU(

	input   wire [31:0] a, b,
	output  reg  [31:0] r,
	output  wire        cf, zf, vf, sf,
	input   wire [4:0]  alufn
);
    wire[4:0] shamt;
    assign shamt = b[4:0];
    wire [31:0] add, sub, op_b;
    wire cfa, cfs;
    //M extension
    wire signed [31:0] signed_A;
    wire signed [31:0] signed_B;
    
    assign signed_A = a;
    assign signed_B = b;
    
    wire [63:0] product_unsigned = a*b;
    wire [63:0] product_signed = signed_A*signed_B;
    wire [63:0] product_su = signed_A*$signed({1'b0, b});
    wire [31:0] division_unsigned = a/b;
    wire [31:0] division_signed = signed_A/signed_B; 
    wire [31:0] rem_unsigned = a%b;
    wire [31:0] rem_signed = signed_A%signed_B; 
    
    
    assign op_b = (~b);
    
    assign {cf, add} = alufn[0] ? (a + op_b + 1'b1) : (a + b);
    
    assign zf = (add == 0);
    assign sf = add[31];
    assign vf = (a[31] ^ (op_b[31]) ^ add[31] ^ cf);
    
    wire[31:0] sh;
    shifter shifter0(.a(a), .shamt(shamt), .type(alufn[1:0]),  .r(sh));
    
    always @ * begin
        r = 0;
        (* parallel_case *)
        case (alufn)
            // arithmetic
            5'b000_00 : r = add;
            5'b000_01 : r = add;
            5'b000_11 : r = b;
            // logic
            5'b001_00:  r = a | b;
            5'b001_01:  r = a & b;
            5'b001_11:  r = a ^ b;
            // shift
            5'b010_00:  r=sh;
            5'b010_01:  r=sh;
            5'b010_10:  r=sh;
            // slt & sltu
            5'b011_01:  r = {31'b0,(sf != vf)}; 
            5'b011_11:  r = {31'b0,(~cf)};
            `ALU_MUL:  r = product_unsigned[31:0];
            `ALU_MULH: r = product_signed[63:32];
            `ALU_MULHU: r = product_unsigned[63:32]; 
            `ALU_MULHSU: r = product_su[63:32];
            `ALU_DIV: begin
             if(signed_A == 32'b10000000000000000000000000000000 && signed_B == 32'b11111111111111111111111111111111) r = 32'b10000000000000000000000000000000;
             else if(b) r = division_signed;
             else r = -1;
             end
            `ALU_DIVU: begin
             if(b) r = division_unsigned;
             else r  = 32'b11111111111111111111111111111111;
             end
            `ALU_REM: begin
             if(signed_A == 32'b10000000000000000000000000000000 && signed_B == 32'b11111111111111111111111111111111) r = 32'b00000000000000000000000000000000;
             if(b) r = rem_signed;
             else r = a;
             end
            `ALU_REMU: begin
            if(b) r = rem_unsigned;
            else r = a;
            end
             
                    	
        endcase
    end
endmodule
