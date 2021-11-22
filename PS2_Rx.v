`timescale 1ns / 1ps
/*
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: 尘世
//
// Create Date: 2021/10/19/08点39分
// Design Name: UART
// Module Name: UART_Rx
// Project Name: UART
// Target Devices:
// Tool Versions:
// Description:
// PS_2的接收模块
// 当时钟来时就开始接收数据，根据协议共有8+1+1+1=11位信号
// 停止位并不影响数据的接收逻辑，只与发送有关
// Dependencies:
// Revision:
// Revision 0.01 - File Created
// Additional Comments:

// output data  接收到的实际数据
// input clk    系统时钟100M
// input rst    同步复位

    本代码只提供发送和接收两个模块。不提供顶层的模块。
    本代码和UART的逻辑非常接近，几乎一致。
    
//////////////////////////////////////////////////////////////////////////////////
*/
module PS2_Rx (
        input clk,
        input PS2_D,
        input arst,
        output reg [7:0] data
    );
    localparam Wait = 0;
    localparam RecieveData = 1;
    localparam RecieveEnd = 2;

    reg [2:0] state=Wait;
    reg [2:0] next_state;
    reg [7:0] data_tmp;
    reg [2:0] count;//计数收到的数据位数
    reg parity;

    always @(*) begin
        case (state)
            Wait:
                next_state=(PS2_D)?Wait:RecieveData;
            RecieveData:
                next_state=(count==7)?RecieveEnd:RecieveData;
            RecieveEnd:
                next_state=Wait;
            default:
                next_state=Wait;
        endcase
    end

    always @(posedge clk or posedge arst) begin
        if (arst) begin
            count<=0;
            state<=Wait;
        end
        else
        case (state)
            Wait: begin
                state<=next_state;
                count<=0;
            end
            RecieveData: begin
                state<=next_state;
                count<=count+1;
            end
            RecieveEnd: begin
                state<=next_state;
                count<=0;
            end
            default: begin
                state<=Wait;
            end
        endcase
    end

    always @(negedge clk or posedge arst) begin
        if (arst) begin
            data<=0;
            data_tmp<=0;
        end
        else
        case (state)
            Wait: begin
                data_tmp<=0;
            end
            RecieveData: begin
                data_tmp[7:0]<={PS2_D,data_tmp[7:1]};
            end
            RecieveEnd: begin
                if (^data_tmp==PS2_D)
                    data<=data_tmp;
            end
            default: begin
                data<=data;
            end
        endcase
    end
endmodule
