
// This is blocking assignments.
module d_ff_blocking(output reg q1, q2, input d, clk);
    
    always @ (posedge clk)
    begin
        q1 = d;			// q1(n+1) = d(n)
        q2 = q1;		// q2(n+1) = q1(n+1) = d(n)
    end
    
endmodule

