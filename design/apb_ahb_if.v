//=====================================================================
// Description:
// AHB Slave interface state machine
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

module apb_ahb_if (
    /* AHB */
    input                            hclk,       // AHB system clock
    input                            hreset_n,   // AHB system reset
    input  [`HADDR_INT_WIDTH-1:0]    haddr_int,  // internal AHB address
    input                            hready,     
    input                            hsel,       // AHB slave select
    input  [`HTRANS_WIDTH-1:0]       htrans,     // AHB transfer type 
    input                            hwrite,     // AHB write/read signal
    input  [`AHB_DATA_WIDTH-1:0]     hwdata,     // AHB write data
    
    output reg                       hreadyout,  
    output                           hresp,      // AHB response
    
    /* APB */
    input                            pready_x,   // APB ready from slave_x (optinal for slave)
    input                            pslverr_x,  // APB slave error from slave_x (optinal for slave)
    output reg                       psel_en,    // APB psel enable
    output reg [`PADDR_WIDTH-1:0]    paddr,      // APB address
    output reg                       penable,    // APB enable
    output reg [`APB_DATA_WIDTH-1:0] pwdata,     // APB write data
    output reg                       pwrite      // APB write/read signal
);

/* internal signal and reg */
wire                        ahb_sel_idd;     // 当前确实被选中
wire                        ahb_tran_idd;    // 当前传输 transaction 确实有效
wire                        ahb_valid;       // 当前有效选中

// 同名寄存器的 wire 类型
wire [`HADDR_INT_WIDTH-1:0] piped_haddr_w;   
wire [`AHB_DATA_WIDTH-1:0]  piped_hwdata_w;
wire                        piped_hwrite_w;

wire [`PADDR_WIDTH-1:0]     paddr_w;
wire [`APB_DATA_WIDTH-1:0]  pwdata_w;       
wire                        pwrite_w;


reg [2:0]                   nextstate;        // 下一状态寄存器
reg [2:0]                   state;            // 当前状态寄存器

reg [`HADDR_INT_WIDTH-1:0]  piped_haddr;      // 存储 AHB 地址
reg [`AHB_DATA_WIDTH-1:0]   piped_hwdata;     // 存储 AHB 写数据
reg                         piped_hwrite;     // 存储 AHB 的传输方向




/* FSM definition */
parameter IDLE                = 3'b000;
parameter WRITE_WAIT_PIPLINE  = 3'b001;
parameter WRITE_SETUP         = 3'b010;
parameter READ_SETUP          = 3'b011; 





/* connection */

/*
 * 1. 确定当前 AHB slave 被选中，并且其他 slave 的传输任务已完成
 * 2. 当条件1满足时，确定当前传输 transaction 的类型
 */
assign ahb_sel_idd  = hsel && hready;
assign ahb_tran_idd = (htrans != `IDLE) && (htrans != `BUSY);
assign ahb_valid    = ahb_sel_idd && ahb_tran_idd;






/* always block */

/*
 * 保存 AHB 总线上的地址
 */
assign piped_haddr_w = piped_haddr;
always @(posedge hclk) begin
    if (hreset_n == 1'b0) begin
        piped_haddr <= {`HADDR_INT_WIDTH{1'b0}};
    end
    else begin
        case (state)
            // Q：不仅仅idle状态要记录地址
            IDLE : begin
                if (ahb_valid == 1'b1) begin
                    piped_haddr <= haddr_int;
                end
            end 
            default: piped_haddr <= piped_haddr_w;
        endcase
    end
end

/*
 * 保存 AHB 的传输方向
 * 
 * 因为 AHB 的流水操作，传输方向的指明和地址保持同步，
 * 因此，传输方向和地址有着一致的采样时刻
 */
assign piped_hwrite_w = piped_hwrite;
always @(posedge hclk) begin
    if (hreset_n == 1'b0) begin
        piped_hwrite <= 1'b0;
    end
    else begin
        case (state)
            // Q：不仅仅idle状态要记录地址
            IDLE : begin
                if (ahb_valid == 1'b1) begin
                    piped_hwrite <= hwrite;
                end
            end 
            default: piped_hwrite <= piped_hwrite_w;
        endcase
    end
end

/*
 * 保存 AHB 总线上的写数据
 *
 * 对于写入传输事务，只有得到完全的 AHB 总线信息(地址和数据)，
 * 才能在进入 APB 的 Setup 阶段
 */
assign piped_hwdata_w = piped_hwdata;
always @(posedge hclk) begin
    if (hreset_n == 1'b0) begin
        piped_hwdata <= {`AHB_DATA_WIDTH{1'b0}};
    end
    else begin
        case (state)
            WRITE_WAIT_PIPLINE : piped_hwdata <= hwdata;
            default: piped_hwdata <= piped_hwdata_w;
        endcase
    end
end


/* 
 * 状态机的切换
 */
always @(posedge hclk) begin
    if (hreset_n == 1'b0) begin
        state <= IDLE;
    end
    else begin
        state <= nextstate;
    end
end

always @(*) begin
    case (state)
        //
        // 总线上有一些传输事务需要接受或拒绝，
        // 如果接受，则需要决定读取或写入。 
        // 如果是写入事务，需要等待地址和数据都就位
        // 如果是读取事务，仅需要等待地址就位
        //
        IDLE : begin
            if (ahb_valid == 1'b1) begin
                // 接受当前的传输事务
                if ( hwrite == 1'b1) begin
                    // 写入传输事务
                    nextstate = WRITE_WAIT_PIPLINE; // 进入下一个状态等待写数据
                end
                else begin
                    // 读取传输事务
                    nextstate = READ_SETUP;
                end
            end
        end

        //
        // 获取写数据，进入到 APB 写入传输的 Setup 阶段
        //
        WRITE_WAIT_PIPLINE : begin
            nextstate = WRITE_SETUP;
        end

        default : nextstate = IDLE;
    endcase
end

endmodule