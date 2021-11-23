`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/15 10:47:35
// Design Name: 
// Module Name: bcd_fadd
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


module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
    assign sum[3:0]=({1'b0,a[3:0]}+{1'b0,b[3:0]}+{3'b000,cin})%4'b1010;
    assign cout=({1'b0,a[3:0]}+{1'b0,b[3:0]}+{3'b000,cin})/4'b1010;

endmodule
