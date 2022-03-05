
// The output of a Mealy state machine is a function of the current state and inputs.
module mealy(clk, din, op);
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
        case ( current_state )
            S0:begin
                if(din == 0)
                    begin
                    next_state = S0;
                    op = 0;             // The output is a function of the current state and inputs.
                    end
                else
                    begin
                    next_state = S1;
                    op = 1;
                    end
                end
                
            S1:begin
                if(din == 1)
                    begin
                    next_state = S1;
                    op = 1;
                    end
                else
                    begin
                    next_state = S2;
                    op = 0;
                    end
                end
            
            S2:begin
                if(din == 1)
                    begin
                    next_state = S2;
                    op = 0;
                    end
                else
                    begin
                    next_state = S3;
                    op = 1;
                    end
                end
            
            S3:begin
                if(din == 0)
                    begin
                    next_state = S3;
                    op = 0;
                    end
                else
                    begin
                    next_state = S0;
                    op = 1;
                    end
                end
            
            default:begin
                op = 0;
                next_state = S0;
            end
            
        endcase
    end
    
endmodule

