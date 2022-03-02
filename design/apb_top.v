//=====================================================================
// Description:
// the top level of the ahb2apb bridge and apb bus (AMBA 5)
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

module apb_top (
    /* AHB */ 
    input                        hclk,       // AHB system clock
    input                        hreset_n,   // AHB system reset
    input  [`HADDR_WIDTH-1:0]    haddr,      // AHB address bus
    input                        hready,     // AHB ready signal
    input                        hsel,       // AHB slave select signal
    input  [`HTRANS_WIDTH-1:0]   htrans,     // AHB transfer type bus
    input                        hwrite,     // AHB write signal
    input  [`HSIZE_WIDTH-1:0]    hsize,      // AHB transfer size
    input  [`HBURST_WIDTH -1:0]  hburst,     // AHB transfer burst type
    output                       hresp,      // AHB response
    output                       hreadyout,  // AHB ready output
    input  [`AHB_DATA_WIDTH-1:0] hwdata,     // AHB write data bus
    output [`AHB_DATA_WIDTH-1:0] hrdata,     // AHB read data bus
    
    /* APB */
    output                       penable,    // APB enable
    output [`PADDR_WIDTH-1:0]    paddr;      // APB address bus
    output                       pwrite,     // APB write
    output [`APB_DATA_WIDTH-1:0] pwdata,     // APB write data
    // apb slvae_0
    output                       psel_0,     // APB select slave_x
    input  [`APB_DATA_WIDTH-1:0] prdata_0,   // APB read data from slave_x
    input                        pready_0,   // APB ready from slave_x (optinal for slave)
    input                        pslverr_0,  // APB slave error from slave_x (optinal for slave)
    // apb slvae_1
    output                       psel_1,
    input  [`APB_DATA_WIDTH-1:0] prdata_1,
    input                        pready_1,
    input                        pslverr_1,
    // apb slvae_2
    output                       psel_2,
    input  [`APB_DATA_WIDTH-1:0] prdata_2,
    input                        pready_2,
    input                        pslverr_2,
    // apb slvae_3
    output                       psel_3,
    input  [`APB_DATA_WIDTH-1:0] prdata_3,
    input                        pready_3,
    input                        pslverr_3,
    // apb slvae_4
    output                       psel_4,
    input  [`APB_DATA_WIDTH-1:0] prdata_4,
    input                        pready_4,
    input                        pslverr_4,
    // apb slvae_5
    output                       psel_5,
    input  [`APB_DATA_WIDTH-1:0] prdata_5,
    input                        pready_5,
    input                        pslverr_5,
    // apb slvae_6
    output                       psel_6,
    input  [`APB_DATA_WIDTH-1:0] prdata_6,
    input                        pready_6,
    input                        pslverr_6,
    // apb slvae_7
    output                       psel_7,
    input  [`APB_DATA_WIDTH-1:0] prdata_7,
    input                        pready_7,
    input                        pslverr_7,
    // apb slvae_8
    output                       psel_8,
    input  [`APB_DATA_WIDTH-1:0] prdata_8,
    input                        pready_8,
    input                        pslverr_8,
    // apb slvae_9
    output                       psel_9,
    input  [`APB_DATA_WIDTH-1:0] prdata_9,
    input                        pready_9,
    input                        pslverr_9,
    // apb slvae_10
    output                       psel_10,
    input  [`APB_DATA_WIDTH-1:0] prdata_10,
    input                        pready_10,
    input                        pslverr_10,
    // apb slvae_11
    output                       psel_11,
    input  [`APB_DATA_WIDTH-1:0] prdata_11,
    input                        pready_11,
    input                        pslverr_11
);


    
endmodule