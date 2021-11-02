// file: mux.v
// author: @hashoom

`timescale 1ns/1ns

module mux(A, B, S, Y);
input A, B, S;
output Y;
assign Y = S?B:A;

endmodule
