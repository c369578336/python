`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/14 09:57:18
// Design Name: 
// Module Name: top_module
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/14 09:57:18
// Design Name: 
// Module Name: top_module
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
module twelve_hour_clk(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    wire flag;
    assign flag =((hh[7:4]==1)&(hh[3:0]==1)&(mm[7:4]==5)&(mm[3:0]==9)&(ss[7:4]==5)&(ss[3:0]==9));
    always @(posedge clk )
    begin
        if (clk)
            if (reset )
                pm=0;
                else if (flag)
                    pm=~pm;
    end
    wire load_hh;
    wire ena_hh;
    decadehh u_hh(
    .clk                     ( clk      ),
    .reset                   ( reset    ),
    .enable                  ( ena_hh   ),
    .load                    ( load_hh   ),
    .d                        ( 4'd0   ),
    .q                       ( hh[7:4]        )
    );

    assign  load_hh= (hh[7:4]==1)&(hh[3:0]==2)&(mm[7:4]==5)&(mm[3:0]==9)&(ss[7:4]==5)&(ss[3:0]==9);
    assign  ena_hh= ((hh[3:0]==9)&(mm[7:4]==5)&(mm[3:0]==9)&(ss[7:4]==5)&(ss[3:0]==9))|((hh[7:4]==1)&(hh[3:0]==2)&(mm[7:4]==5)&(mm[3:0]==9)&(ss[7:4]==5)&(ss[3:0]==9))&ena;
//    assign  hh =reset?8'h12:h ;
    wire ena_hl;
    decadehl u_hl(
    .clk                     ( clk      ),
    .reset                   ( reset    ),
    .enable                  ( ena_hl   ),
    .load                    ( load_hh   ),
    .d                        ( 4'd1   ),
    .q                       ( hh[3:0]        )
    );
    assign  ena_hl= (mm[7:4]==5)&(mm[3:0]==9)&(ss[7:4]==5)&(ss[3:0]==9)&ena;

    wire ena_mh;
    wire load_mh;
    decade u_mh(
    .clk                     ( clk      ),
    .reset                   ( reset    ),
    .enable                  ( ena_mh   ),
    .load(load_mh),
    .d(4'd0),
    .q                       ( mm[7:4]        )
    );
    assign  ena_mh= (mm[3:0]==9)&(ss[7:4]==5)&(ss[3:0]==9)&ena;
    assign load_mh = (mm[7:4]==5)&(mm[3:0]==9)&(ss[7:4]==5)&(ss[3:0]==9);

    wire ena_ml;
    decade u_ml(
    .clk                     ( clk      ),
    .reset                   ( reset    ),
    .enable                  ( ena_ml   ),

    .q                       ( mm[3:0]        )
    );
    assign  ena_ml= (ss[7:4]==5)&(ss[3:0]==9)&ena;

    wire ena_sh;
    wire load_sh;
    decade u_sh(
    .clk                     ( clk      ),
    .reset                   ( reset    ),
    .enable                  ( ena_sh   ),
    .load(load_sh),
    .d(4'd0),
    .q                       ( ss[7:4]        )
    );
    assign  ena_sh= (ss[3:0]==9)&ena;
    assign load_sh = (ss[7:4]==5)&(ss[3:0]==9);

    wire ena_sl;
    decade u_sl(
    .clk                     ( clk      ),
    .reset                   ( reset    ),
    .enable                  ( ena   ),

    .q                       ( ss[3:0]        )
    );
endmodule

module decade (
    input clk,
    input reset,      // Synchronous active-high reset
    input enable,
    input load,
    input [3:0] d,
    output reg [3:0] q);
    always @(posedge clk ) begin
        if (clk) begin
            if (reset)begin
                q=4'b0000;
            end
            else if (enable)
                if (load)
                    q=d;
                    else if (q==9)
                    q=0;
                    else q=q+1;
        end
    end
endmodule

module decadehh (
    input clk,
    input reset,      // Synchronous active-high reset
    input enable,
    input load,
    input [3:0] d,
    output reg [3:0] q);
    always @(posedge clk ) begin
        if (clk) begin
            if (reset)begin
                q=4'b0001;
            end
            else if (enable)
                if (load)
                    q=d;
                    else if (q==9)
                    q=0;
                    else q=q+1;
        end
    end
endmodule

module decadehl (
    input clk,
    input reset,      // Synchronous active-high reset
    input enable,
    input load,
    input [3:0] d,
    output reg [3:0] q);
    always @(posedge clk ) begin
        if (clk) begin
            if (reset)begin
                q=4'b0010;
            end
            else if (enable)
                if (load)
                    q=d;
                    else if (q==9)
                    q=0;
                    else q=q+1;
        end
    end
endmodule