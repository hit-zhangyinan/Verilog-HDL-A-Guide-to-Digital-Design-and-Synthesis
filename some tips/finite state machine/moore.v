
// The output of a Moore state machine is a function of the current state only.
module moore (clk, din, op);
    input clk, din;
    output op;
    reg [1:0] current_state, next_state;
    reg op;
    
    parameter S0 = 2 'b 00;
    parameter S1 = 2 'b 01;
    parameter S2 = 2 'b 10;
    parameter S3 = 2 'b 11;
    
    always @ (posedge clk)
    begin
        current_state <= next_state;
    end
    
    always @ (current_state or din)
    begin
        case( current_state )
            S0:begin
                op = 0;                     //The output is a function of the current state only.
                if(din == 0)
                    next_state = S0;
                else
                    next_state = S1;
                end
            
            S1:begin
                op = 1;
                if(din == 1)
                    next_state = S1;
                else
                    next_state = S2;
                end
                
            S2:begin
                op = 0;
                if(din == 1)
                    next_state = S2;
                else
                    next_state = S3;
                end
                
            S3:begin
                op = 0;
                if(din == 0)
                    next_state = S3;
                else
                    next_state = S0;
                end
                
            default:begin
                op = 0;
                next_state = S0;
                    end
            
        endcase
    end
    
endmodule

