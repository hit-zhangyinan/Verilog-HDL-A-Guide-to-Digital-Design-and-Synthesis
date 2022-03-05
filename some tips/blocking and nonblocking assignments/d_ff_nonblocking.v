
// This is nonblocking assignments.
module d_ff_nonblocking(output reg q1, q2, input d, clk);
    
    always @ (posedge clk)
    begin
        q1 <= d;            // q1(n+1) = d(n)
        q2 <= q1;           // q2(n+1) = q1(n) = d(n-1)
    end
    
endmodule

