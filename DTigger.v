module DTigger
    #(
        parameter Baud = 9600
    )
    (
        input clk,
        input D,
        output reg Q
    );
    always @(negedge clk_out) begin
        Q=D;
    end

    ClkDiv #(
               .Baud(Baud)
           )
           u_ClkDiv
           (
               .clk(clk),
               .clk_out(clk_out)
           );

endmodule
