// file: RegFile.v
// author: @hashoom

`timescale 1ns/1ns

module RegFile #(parameter N = 32)(input clk, rst, input [4:0]read_reg1, read_reg2, write_reg, input [N-1:0] write_data, input regWrite, output [N-1:0] read_data1, read_data2);
wire [N-1:0]load, final_load;
wire [N-1:0] Q[31:0];

decoder #(N) d (write_reg, load);
mux_W #(N) w(32'd0,load, regWrite, final_load);
genvar i;
    generate
        for(i=1; i<N ; i= i+1) begin: HB2
        n_bit_reg_file #(N) tuu(.clk(~clk), .rst(rst), .load(final_load[i]), .D(write_data), .Q(Q[i]));
        end
    endgenerate
    assign Q[0] = 32'd0;
   assign read_data1=  Q[read_reg1];
   assign read_data2=  Q[read_reg2];
    
// n_bit_mux r1(Q, read_reg1, read_data1);
// n_bit_mux r2(Q, read_reg2, read_data2);

endmodule
