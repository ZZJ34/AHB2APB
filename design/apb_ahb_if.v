//=====================================================================
// Description:
// AHB Slave interface state machine
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

module apb_ahb_if (
    /* AHB */
    input                          hclk,       // AHB system clock
    input                          hreset_n,   // AHB system reset
    input  [`HADDR_INT_WIDTH-1:0]  haddr_int,  // internal AHB address
    input                          hready,     
    input                          hsel,       // AHB slave select
    input  [`HTRANS_WIDTH-1:0]     htrans,     // AHB transfer type 
    input                          hwrite,     // AHB write/read signal
    input  [`AHB_DATA_WIDTH-1:0]   hwdata,     // AHB write data
    output                         hreadyout,  
    output                         hresp,      // AHB response
    
    /* APB */
    input                          pready_x,   // APB ready from slave_x (optinal for slave)
    input                          pslverr_x,  // APB slave error from slave_x (optinal for slave)
    output [`PADDR_WIDTH-1:0]      paddr,      // APB address
    output                         penable,    // APB enable
    output [`APB_DATA_WIDTH-1:0]   pwdata,     // APB write data
    output                         pwrite      // APB write/read signal
);

/* internal signal and reg */
wire              ahb_sel_idd;     // 当前确实被选中
wire              ahb_tran_idd;    // 当前传输 transaction 确实有效
wire              ahb_slave_valid; // 当前有效选中

reg   [2:0]       nextstate;
reg   [2:0]       state;

/* FSM definition */
parameter IDLE         = 3'b000;
parameter WRITE_WAIT   = 3'b001;   // 写等待，等待 pready
parameter WRITE_SETUP  = 3'b010;   // 写选择->此时 psel 拉高
parameter WRITE_ENABLE = 3'b011;   // 写使能->此时 penable 拉高
parameter READ_WAIT    = 3'b100;   // 读等待，等待 pready
parameter READ_SETUP   = 3'b101;   // 读选择->此时 psel 拉高
parameter READ_ENABLE  = 3'b110;   // 读使能->此时 penable 拉高

/* connection */

/*
* 1. 确定当前 AHB slave 被选中，并且其他 slave 的 transaction 以及完成
* 2. 当条件1满足时，确定当前传输 transaction 的类型
*/
assign ahb_sel_idd  = hsel && hready;
assign ahb_tran_idd = (htrans != `IDLE) && (htrans != `BUSY));
assign ahb_slave_valid = ahb_sel_idd && ahb_tran_idd;

/* always block */


endmodule