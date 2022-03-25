`timescale 1ns/1ns

module async_fifo_tb();
    
reg [7:0] wdata;
reg       winc, wclk, wrst_n;
reg       rinc, rclk, rrst_n;
    
wire [7:0] rdata;
wire       wfull, rempty;

fifo1 fifo1 (   .rdata(rdata),
                .wfull(wfull),
                .rempty(rempty),
                .wdata(wdata),
                
                .winc(winc),
                .wclk(wclk),
                .wrst_n(wrst_n),
                
                .rinc(rinc),
                .rclk(rclk),
                .rrst_n(rrst_n)     );
                
localparam CYCLE  = 10;
localparam CYCLE1 = 12;
    
initial begin
    wclk = 0;
    forever #( CYCLE  /2 ) wclk = ~wclk;
end

initial begin
    rclk = 0;
    forever #( CYCLE1 /2 ) rclk = ~rclk;
end

initial begin
    wrst_n = 1;
    #2 wrst_n = 0;
    #( CYCLE ) wrst_n = 1;
end

initial begin
    rrst_n = 1;
    #2 rrst_n = 0;
    #( CYCLE ) rrst_n = 1;
end

/*
always @ (posedge wclk or negedge wrst_n)
begin
    if ( wrst_n == 1'b0 )
        winc <= 0;
    else
        winc <= 1;
end

always @ (posedge rclk or negedge rrst_n)
begin
    if ( rrst_n == 1'b0 )
        rinc <= 0;
    else
        rinc <= 1;
end
*/

initial begin
            winc = 1;   rinc = 0;
    #200    winc = 0;   rinc = 1;
end

always @ (negedge wclk)
begin
    if ( wrst_n == 0 )
        wdata <= 0;
    else
        wdata <= wdata + 1;
end

endmodule
