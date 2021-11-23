//一段式,基本弃用
// Note the Verilog-1995 module declaration syntax here:
module Moore_one(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//
    reg out;

    // Fill in state name declarations
    parameter A = 0;
    parameter B = 1;
    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            // Fill in reset logic
            present_state=B;
            next_state=B;
            out=B;
        end
        else begin
            case (present_state)
                // Fill in state transition logic
                A:
                    next_state=(in)?present_state:B;
                B:
                    next_state=(in)?present_state:A;
            endcase

            // State flip-flops
            present_state = next_state;

            case (present_state)
                // Fill in output logic
                A:
                    out=A;
                B:
                    out=B;
            endcase
        end
    end

endmodule
//三段式
module Moore_three(
        input clk,
        input areset,    // Asynchronous reset to state B
        input in,
        output out);//

    parameter A=0, B=1;
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        if (in==0) begin
            if (state)
                next_state<=A;
            else begin
                next_state <= B;
            end
        end
        else
            next_state=state;
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (areset) begin
            state<=B;
        end
        else if(clk == 1'b1) begin
            state <= next_state;
        end
    end

    // Output logic
    // assign out = (state == ...);
    assign out = (state==A)?0:1;
endmodule
