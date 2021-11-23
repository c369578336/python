`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/14 09:57:18
// Design Name: 
// Module Name: Bcdadd100_instance_array
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 用generate的方式建立100个Bcd加法器并连线
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Bcdadd100_generate( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [99:1] m_cout;

    genvar i;
    generate
        for (i=0;i<100;i=i+1) begin:bcd
            if (i)
                if (i==99)
                bcd_fadd  u_bcd_fadd (
                    .a                       ( a     [i*4+3:i*4] ),
                    .b                       ( b     [i*4+3:i*4] ),
                    .cin                     (m_cout[99]         ),

                    .cout                    (cout               ),
                    .sum                     ( sum   [i*4+3:i*4] )
                );
                else 
                bcd_fadd  u_bcd_fadd (
                    .a                       ( a     [i*4+3:i*4] ),
                    .b                       ( b     [i*4+3:i*4] ),
                    .cin                     (m_cout    [i]),

                    .cout                    (m_cout  [i+1]  ),
                    .sum                     ( sum   [i*4+3:i*4] )
                );
                else
                bcd_fadd  u_bcd_fadd (
                    .a                       ( a     [3:0] ),
                    .b                       ( b     [3:0] ),
                    .cin                     (cin),

                    .cout                    (m_cout  [1]  ),
                    .sum                     ( sum   [3:0] )
                );
        end
    endgenerate 
endmodule
