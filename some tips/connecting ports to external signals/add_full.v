
// This is a 1-bit full adder
module add_full(A, B, C, Carry, S);
    input A, B, C;
    output Carry, S;
    
    assign S = A ^ B ^ C;
    assign Carry = ( A & B ) | ( B & C ) | ( A & C );
endmodule
