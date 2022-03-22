module fifomem #( parameter DATASIZE = 8,
                  parameter ADDRSIZE = 4 )
(
    output [DATASIZE-1:0] rdata,
    
    input  [DATASIZE-1:0] wdata,
    input  [ADDRSIZE-1:0] waddr, raddr,
    input                 wclken, wfull, wclk
);

`ifdef VENDORRAM
vendor_ram mem
(.dout(rdata), .din(wdata), .waddr(waddr), .raddr(raddr),
 .wclken(wclken), .wclken_n(wfull), .clk(wclk) );
 
`else
localparam DEPTH = ( 1 << ADDRSIZE );
reg [DATASIZE-1:0] mem [0:DEPTH-1];

assign rdata = mem[raddr];

always @ (posedge wclk)
if ( wclken && !wfull ) mem[waddr] <= wdata;

`endif

endmodule

