
`define Y2RDELAY 3
`define R2GDELAY 2

// Moore Finite State Machine

module sig_control( output reg [1:0] hwy, cntry, 
                    input clock, clear,
                    input X
);

parameter   RED = 2 'd 0,
            YELLOW = 2 'd 1,
            GREEN = 2 'd 2;

parameter   S0 = 3 'd 0,
            S1 = 3 'd 1,
            S2 = 3 'd 2,
            S3 = 3 'd 3,
            S4 = 3 'd 4;

reg [2:0] state, next_state;

always @ (posedge clock) begin
    if(clear)
        state <= S0;
    else
        state <= next_state;
end

always @ (state or X)
begin
    case (state)
        S0:if(X)
            next_state = S1;
        else
            next_state = S0;
        
        S1:begin
            repeat(`Y2RDELAY) @ (posedge clock);
            next_state = S2;
        end
        
        S2:begin
            repeat(`R2GDELAY) @ (posedge clock);
            next_state = S3;
        end
        
        S3:if(X)
        next_state = S3;
    else
        next_state = S4;
        
        S4:begin
            repeat(`Y2RDELAY) @ (posedge clock);
            next_state = S0;
        end
        
        default:next_state = S0;
    endcase
end

always @ (state)
begin
    hwy = GREEN;
    cntry = RED;
    case(state)
        S0: ;
        S1: hwy = YELLOW;
        S2: hwy = RED;
        S3: begin
            hwy = RED;
            cntry = GREEN;
        end
        S4: begin
            hwy = RED;
            cntry = YELLOW;
        end
    endcase
end

endmodule

