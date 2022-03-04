
// This is a 4-bit full adder.
module add_full4_by_position(A, B, C, S);
    input [3:0] A, B;
    output [3:0] S;
    output [4:0] C;
    assign C[0] = 0;
    
    // "son module name" + "a user-defined name" + ( Current module ports' names )
    add_full u1(A[0], B[0], C[0], C[1], S[0]);
    add_full u2(A[1], B[1], C[1], C[2], S[1]);
    add_full u3(A[2], B[2], C[2], C[3], S[2]);
    add_full u4(A[3], B[3], C[3], C[4], S[3]);
endmodule
