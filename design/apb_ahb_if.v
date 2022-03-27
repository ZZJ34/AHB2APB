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
    output reg                       hresp,      // AHB response
    output reg [`AHB_DATA_WIDTH-1:0] hrdata,    
    
    /* APB */
    input                            pready_x,   // APB ready from slave_x (optinal for slave)
    input                            pslverr_x,  // APB slave error from slave_x (optinal for slave)
    input  [`APB_DATA_WIDTH-1:0]     prdata_x,   // APB read data from slave_x
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

wire                        psel_en_w;
wire                        penable_w;

wire [`AHB_DATA_WIDTH-1:0]  prdata_reg_w;

reg [`HADDR_INT_WIDTH-1:0]  piped_haddr;      // 存储 AHB 地址
reg [`AHB_DATA_WIDTH-1:0]   piped_hwdata;     // 存储 AHB 写数据
reg                         piped_hwrite;     // 存储 AHB 传输方向
 
reg [`AHB_DATA_WIDTH-1:0]   prdata_reg;       // 存储 APB 读取数据


reg [3:0]                   next_state;       // 下一状态寄存器
reg [3:0]                   state;            // 当前状态寄存器

/* FSM definition */
parameter IDLE                = 4'b0000;
// write state
parameter WRITE_WAIT_PIPLINE  = 4'b0001;
parameter WRITE_SETUP         = 4'b0010;
parameter WRITE_ENABLE        = 4'b0011;
parameter WRITE_WAIT          = 4'b0100;
parameter WRITE_SUCCESS       = 4'b0101;
// read state
parameter READ_SETUP          = 4'b0110;
parameter READ_ENABLE         = 4'b0111;
parameter READ_WAIT           = 4'b1000;  
parameter READ_SUCCESS        = 4'b1001;
// error state
parameter ERROR_1             = 4'b1010;
parameter ERROR_2             = 4'b1011;



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
            IDLE, WRITE_SUCCESS, READ_SUCCESS, ERROR_2 : begin
                if (ahb_valid == 1'b1)
                    piped_haddr <= haddr_int;
                else
                    piped_haddr <= {`HADDR_INT_WIDTH{1'b0}};
            end 
            default: piped_haddr <= piped_haddr_w;
        endcase
    end
end

/*
 * 保存 AHB 的传输方向
 * 
 * 因为 AHB 的流水操作，传输方向的指明和地址保持同步，
 * 因此，传输方向和地址有着一致的采样时刻。 
 */
assign piped_hwrite_w = piped_hwrite;
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        piped_hwrite <= 1'b0;
    else begin
        case (state)
            IDLE, WRITE_SUCCESS, READ_SUCCESS, ERROR_2 : begin
                if (ahb_valid == 1'b1) 
                    piped_hwrite <= hwrite;
                else
                    piped_hwrite <= 1'b0;
            end 
            default: piped_hwrite <= piped_hwrite_w;
        endcase
    end
end

/*
 * 保存 AHB 总线上的写数据
 *
 * 对于写入传输事务，只有得到完全的 AHB 总线信息(地址和数据)，
 * 才能在进入 APB 的 Setup 阶段。
 */
assign piped_hwdata_w = piped_hwdata;
always @(posedge hclk) begin
    if (hreset_n == 1'b0) 
        piped_hwdata <= {`AHB_DATA_WIDTH{1'b0}};
    else begin
        case (state)
            WRITE_WAIT_PIPLINE : piped_hwdata <= hwdata;
            default: piped_hwdata <= piped_hwdata_w;
        endcase
    end
end

/*
* AHB 总线 hreadyout
*
* IDLE状态拉高，此外仅在读写成功完成以及错误响应的第二个周期拉高
*/
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        hreadyout <= 1'b1;
    else begin
        case (next_state)
            IDLE, WRITE_SUCCESS, READ_SUCCESS, ERROR_2 : hreadyout <= 1'b1;
            default: hreadyout <= 1'b0;
        endcase
    end
end

/*
* AHB 总线 hresp
*
* 仅在错误响应时拉高
*/
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        hresp <= `OKAY;
    else begin
        case (next_state)
            ERROR_1, ERROR_2 : hresp <= `ERROR;
            default: hresp <= `OKAY;
        endcase
    end
end

/*
* AHB 总线 hrdata
*/
always @(*) begin
    hrdata = prdata_reg_w;
end

/*
* APB 总线 psel_en
* 
* APB 总线 setup phase 开始拉高，完成时拉低
*/
assign psel_en_w = psel_en;
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        psel_en <= 1'b0;
    else begin
        case(next_state)
            WRITE_SETUP, READ_SETUP : psel_en <= 1'b1;
            WRITE_SUCCESS, READ_SUCCESS, ERROR_1 : psel_en <= 1'b0;
            default: psel_en <= psel_en_w;
        endcase
    end
end

/*
* APB 总线 penable
* 
* APB 总线 access phase 开始拉高，完成时拉低
*/
assign penable_w = penable;
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        penable <= 1'b0;
    else begin
        case(next_state)
            WRITE_ENABLE, READ_ENABLE : penable <= 1'b1;
            WRITE_SUCCESS, READ_SUCCESS, ERROR_1 : penable <= 1'b0;
            default: penable <= penable_w;
        endcase
    end
end

/*
* APB 总线 prdata
*/
assign prdata_reg_w = prdata_reg;
always @(posedge hclk) begin
    if (hreset_n == 1'b0)
        prdata_reg <= {`AHB_DATA_WIDTH{1'b0}};
    else begin
        if (pready_x == 1'b1)
            prdata_reg <= prdata_x;
        else
            prdata_reg <= prdata_reg_w;
    end        
end

/*
* APB 总线 paddr，pwdata，pwrite
*/
always @(*) begin
    paddr = piped_haddr_w;
    pwdata = piped_hwdata_w;
    pwrite = piped_hwrite_w;
end


/* 
 * 状态机切换
 */
always @(posedge hclk) begin
    if (hreset_n == 1'b0) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        // 空闲状态，等待 AHB 总线唤醒
        IDLE : begin
            if (ahb_valid == 1'b1) begin
                // 接受当前的传输事务
                if ( hwrite == `WRITE)
                    // 写入传输事务
                    next_state = WRITE_WAIT_PIPLINE; 
                else
                    // 读取传输事务
                    next_state = READ_SETUP;
            end
            else
                next_state = IDLE;
        end

        // 写传输（等待数据），获取 AHB 写事务的数据后 APB 总线进入到 setup phase
        WRITE_WAIT_PIPLINE : next_state = WRITE_SETUP;

        // APB 总线写 setup phase
        WRITE_SETUP : next_state = WRITE_ENABLE;
    
        // APB 总线写 enable phase
        WRITE_ENABLE : begin
            if (pready_x == 1'b0)
                // APB 从设备未准备 
                next_state = WRITE_WAIT;
            else begin
                if (pslverr_x == 1'b0)
                    next_state = WRITE_SUCCESS;
                else
                    next_state = ERROR_1;
            end
        end

        // APB 总线写等待
        WRITE_WAIT : begin
            if (pready_x == 1'b0)
                // APB 从设备未准备 
                next_state = WRITE_WAIT;
            else begin
                if (pslverr_x == 1'b0)
                    next_state = WRITE_SUCCESS;
                else
                    next_state = ERROR_1;
            end
        end

        // APB 总线写完成
        WRITE_SUCCESS : begin
            if (ahb_valid == 1'b1) begin
                if (hwrite == `WRITE)
                    next_state = WRITE_WAIT_PIPLINE; 
                else
                    next_state = READ_SETUP;
            end
            else
                next_state = IDLE;
        end

        // APB 总线读 setup phase
        READ_SETUP : next_state = READ_ENABLE;

        // APB 总线读 enable phase
        READ_ENABLE : begin
            if (pready_x == 1'b0)
                // APB 从设备未准备 
                next_state = READ_WAIT;
            else begin
                if (pslverr_x == 1'b0)
                    next_state = READ_SUCCESS;
                else
                    next_state = ERROR_1;
            end
        end

        // APB 总线读等待
        READ_WAIT : begin
            if (pready_x == 1'b0)
                // APB 从设备未准备 
                next_state = READ_WAIT;
            else begin
                if (pslverr_x == 1'b0)
                    next_state = READ_SUCCESS;
                else
                    next_state = ERROR_1;
            end
        end

        // APB 总线读完成
        READ_SUCCESS : begin
            if (ahb_valid == 1'b1) begin
                if (hwrite == `WRITE)
                    next_state = WRITE_WAIT_PIPLINE; 
                else
                    next_state = READ_SETUP;
            end
            else
                next_state = IDLE;
        end

        ERROR_1 : next_state = ERROR_2;

        ERROR_2 : begin
            if (ahb_valid == 1'b1) begin
                if (hwrite == `WRITE)
                    next_state = WRITE_WAIT_PIPLINE; 
                else
                    next_state = READ_SETUP;
            end
            else
                next_state = IDLE;
        end

        default : next_state = IDLE;

    endcase
end

endmodule