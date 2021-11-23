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
// 用instance array的方式建立100个Bcd加法器并连线
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Bcdadd100_instance_array(
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [98:0] m_cout;

    bcd_fadd  u_bcd_fadd[99:0](
                    .a                       ( a     ),
                    .b                       ( b     ),
                    .cin                     ({m_cout[98:0],cin}         ),

                    .cout                    ( {cout,m_cout[98:0]}),
                    .sum                     ( sum   )
                );
endmodule
