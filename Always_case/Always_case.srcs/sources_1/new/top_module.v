module top_module ();
    reg [1:0] in=0;
    wire out;
    reg clk=0;
    andgate u_andgate(
                .in(in),
                .out(out)
            );
    reg n=1;
    initial begin
        #5 in=in+1;
        #5 in=in+1;
        #5 in=in+1;
        #5 in=in+1;
    end
endmodule
