# 对RTL代码的说明<br>

## 6.1 对 fifo1.v 的说明<br>
fifo1.v 是顶级模块，采用参数化设计，并使用按名称方式进行端口连接来例化子模块。<br>
顶级模块中的子模块例化名称与子模块名称相同。这样做方便查找错误。<br>
DSIZE = 8 表示FIFO的宽度为8，ASIZE = 4 表示有4条地址线，FIFO的深度（地址数目）为2^4 = 16<br>
对输入输出端口进行分析：<br>
`output [7:0] rdata`，`input [7:0] wdata`，输入的 `winc` 代表 write_increment，输入的 `rinc` 代表 read_increment<br>
`wire [3:0] waddr`, `raddr` 代表4位读/写地址线<br>
`wire [4:0] wptr`, `rptr` 代表5位格雷码(Gray code)读/写指针<br>
`wire [4:0] wq2_rptr` 代表5位“经过两个D触发器同步到写(write)时钟域的格雷码读指针(rptr)”<br>
`wire [4:0] rq2_wptr` 代表5位“经过两个D触发器同步到读(read) 时钟域的格雷码写指针(wptr)”<br>

## 6.2 对 fifomem.v 的说明<br>
`output [7:0] rdata，input [7:0] wdata，input [3:0] waddr, raddr`<br>
如果有厂商提供的存储器模型，就进行例化，否则使用 verilog 建模<br>
`DEPTH = ( 1 << 4 )`即`DEPTH = 5'b10000 = 16`<br>
`reg [7:0] mem [0:15]`生成一个宽度为8，深度为16的存储器<br>

## 6.3 对 sync_r2w.v 的说明<br>
这是一个简单的“同步器”模块<br>
`output reg [4:0] wq2_rptr` 代表同步之后的读指针，`input [4:0] rptr` 代表读指针<br>
`reg [4:0] wq1_rptr` 代表经过一级同步的读指针<br>

## 6.4 对 sync_w2r.v 的说明<br>
这是一个简单的“同步器”模块<br>
`output reg [4:0] rq2_wptr` 代表同步之后的写指针，`input [4:0] wptr` 代表写指针<br>
`reg [4:0] rq1_wptr` 代表经过一级同步的写指针<br>

## 6.5 对 rptr_empty.v 的说明<br>
这个模块产生“读指针”和“读空”信号。读指针是一个“双n位格雷码计数器”，`n`位指针（`rptr`）通过`sync_r2w`模块传送到写时钟域，（`n-1`）位指针（`raddr`）用来指向FIFO缓冲器的地址<br>
`output [3:0] raddr, output reg [4:0] rptr, input [4:0] rq2_wptr`<br>
`reg [4:0] rbin;`<br>
`wire [4:0] rgraynext, rbinnext`<br>
`assign raddr = rbin[3:0];`<br>
`assign rempty_val = ( rgraynext == rq2_wptr );`<br>
中的`rempty_val`信号并没有在模块中声明，即这里使用了隐式线网声明。<br>

## 6.6对 wptr_full.v 的说明<br>
这个模块产生“写指针”和“写满”信号。写指针是一个“双n位格雷码计数器”，`n`位指针（`wptr`）通过`sync_w2r`模块传送到读时钟域，（`n-1`）位指针（`waddr`）用来指向FIFO缓冲器的地址<br>
`output [3:0] waddr, output reg [4:0] wptr, input [4:0] wq2_rptr`<br>
`reg [4:0] wbin;`<br>
`wire [4:0] wgraynext, wbinnext`<br>
`assign waddr = wbin[3:0];`<br>
`assign wfull_val = ( wgraynext == { ~wq2_rptr[4:3], wq2_rptr[2:0] } );`<br>
中的`wfull_val`信号并没有在模块中声明，即这里使用了隐式线网声明。<br>
