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

/* output signal and reg */

/* internal signal and reg */

/* FSM definition */

/* connection */

/* always block */


endmodule