
// This is a 4-bit full adder.
module add_full4_by_name(A, B, C, S);
    input [3:0] A, B;
    output [3:0] S;
    output [4:0] C;
    assign C[0] = 0;
    
    // "son module name" + "a user-defined name" + ( ."son module port name"( Current module port name or internal signals ) )
    // "son module" is same as "called module"
    // This way is recommended.
    add_full u1( .A(A[0]), .B(B[0]), .C(C[0]), .Carry(C[1]), .S(S[0]) );
    add_full u2( .A(A[1]), .B(B[1]), .C(C[1]), .Carry(C[2]), .S(S[1]) );
    add_full u3( .A(A[2]), .B(B[2]), .C(C[2]), .Carry(C[3]), .S(S[2]) );
    add_full u4( .A(A[3]), .B(B[3]), .C(C[3]), .Carry(C[4]), .S(S[3]) );
endmodule

