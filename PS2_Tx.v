`timescale 1ns / 1ps
/*
///////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: 尘世
//
// Create Date: 2021�??10�??16�??10:52:38
// Design Name: PS2
// Module Name: PS2_Tx
// Project Name: PS2
// Target Devices:
// Tool Versions:
// Description:
// 建立可用于PS/2通信的发送模�?
// 共有5个状态：
// 1. 等待发�??
// 2. 起始�?
// 3. 数据�?
// 4. 校验�?
// 5. 停止�?
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// PS/2常用于鼠标和键盘向电脑�?�信，有6个�?�道，但是实际使用的只有四个，用于�?�信的只有两个�?�这种�?�信方式已经逐渐被淘�?
// 实际使用的PS/2是双向同步串行�?�信 但是 实际情况�? 电脑很少向鼠标和键盘发�?�信号，因此实际上�?�常只是单向的信号传�?
//  input clk 时钟
    input data待发送的数据
    input arst 异步复位
    output clk_out实际发送的时钟
    output PS2_D发送的串行数据
    本代码只提供发送和接收两个模块。不提供顶层的模块。
    本代码和UART的逻辑非常接近，几乎一致。
    
//////////////////////////////////////////////////////////////////////////////////
*/

module PS2_Tx (
        input clk,
        input [7:0] data,
        input arst,
        input en,
        output PS2_C,
        output reg PS2_D
    );

    localparam Wait = 0;
    localparam SendStart = 1;
    localparam SendData = 2;
    localparam SendEnd = 3;
    localparam SendStop=4;

    reg [2:0] state=Wait;
    reg [2:0] next_state;
    reg [7:0] data_tmp;
    reg [2:0] count;
    reg parity;

    wire clk_out;
    ClkDiv #(
               .Baud ( 10000 )//PS/2的时钟�?�常�?100ms，也就是10kHz
           )
           u_ClkDiv (
               .clk                     ( clk       ),
               .rst                     ( arst       ),

               .clk_out                 ( clk_out   )
           );
    always @(*) begin
        case (state)
            Wait:
                next_state<=en?SendStart:Wait;
            SendStart:
                next_state<=SendData;
            SendData:
                next_state=(count==7)?SendEnd:SendData;
            SendEnd:
                next_state=SendStop;
            SendStop:
                next_state=(~en?Wait:SendStart);
            default:
                next_state<=Wait;
        endcase

    end


    always @(posedge clk_out  or posedge arst) begin
        if (arst) begin
            state=Wait;
            data_tmp=0;
            count=0;
            parity=0;
        end
        else
        case (state)
            Wait: begin
                state=next_state;
            end
            SendStart: begin
                state=next_state;
                data_tmp=data;
                parity=^data;
                count=0;
            end
            SendData: begin
                data_tmp[6:0]=data_tmp[7:1];
                count=count+1;
                state=next_state;
            end
            SendEnd: begin
                state=next_state;
            end
            SendStop: begin
                state=next_state;
            end
            default: begin
                state=Wait;
            end
        endcase
    end

    always @(posedge clk_out ) begin
        case (state)
            Wait:
                PS2_D=1;
            SendStart:
                PS2_D=0;
            SendData:
                PS2_D=data_tmp[0];
            SendEnd:
                PS2_D=parity;
            SendStop:
                PS2_D=1;
            default:
                PS2_D=1;
        endcase
    end

    assign PS2_C = clk_out | state==Wait;
endmodule