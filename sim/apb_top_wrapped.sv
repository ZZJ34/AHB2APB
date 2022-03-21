//=====================================================================
// Description:
// Encapsulate top-level ports
// Designer : zhaozj34@sjtu.edu.cn
// Revision History:
// V0 date:xxx Initial version， zhaozj34@sjtu.edu.cn
// ====================================================================

module apb_top_wrapped(apb_if.AHB2APB _if);

// AHB2APB top level
apb_top i_apb_top(
    .hclk(_if.hclk),       
    .hreset_n(_if.hreset_n),   
    .haddr(_if.haddr),      
    .hready(_if.hready),     
    .hsel(_if.hsel),       
    .htrans(_if.htrans),      
    .hwrite(_if.hwrite),     
    .hsize(_if.hsize),      
    .hburst(_if.hburst),     
    .hresp(_if.hresp),      
    .hreadyout(_if.hreadyout),  
    .hwdata(_if.hwdata),       
    .hrdata(_if.hrdata),
    /* APB */
    .penable(_if.penable),    
    .paddr(_if.paddr),      
    .pwrite(_if.pwrite),     
    .pwdata(_if.pwdata),     
    // apb slvae_0
    .psel_0(_if.psel_0),     
    .prdata_0(_if.prdata_0),   
    .pready_0(_if.pready_0),   
    .pslverr_0(_if.pslverr_0),  
    // apb slvae_1
    .psel_1(_if.psel_1),
    .prdata_1(_if.prdata_1),
    .pready_1(_if.pready_1),
    .pslverr_1(_if.pslverr_1),
    // apb slvae_2
    .psel_2(_if.psel_2),
    .prdata_2(_if.prdata_2),
    .pready_2(_if.pready_2),
    .pslverr_2(_if.pslverr_1),
    // apb slvae_3
    .psel_3(_if.psel_3),
    .prdata_3(_if.prdata_3),
    .pready_3(_if.pready_3),
    .pslverr_3(_if.pslverr_3),
    // apb slvae_4
    .psel_4(_if.psel_4),
    .prdata_4(_if.prdata_4),
    .pready_4(_if.pready_4),
    .pslverr_4(_if.pslverr_4),
    // apb slvae_5
    .psel_5(_if.psel_5),
    .prdata_5(_if.prdata_5),
    .pready_5(_if.pready_5),
    .pslverr_5(_if.pslverr_5),
    // apb slvae_6
    .psel_6(_if.psel_6),
    .prdata_6(_if.prdata_6),
    .pready_6(_if.pready_6),
    .pslverr_6(_if.pslverr_6),
    // apb slvae_7
    .psel_7(_if.psel_7),
    .prdata_7(_if.prdata_7),
    .pready_7(_if.pready_7),
    .pslverr_7(_if.pslverr_7),
    // apb slvae_8
    .psel_8(_if.psel_8),
    .prdata_8(_if.prdata_8),
    .pready_8(_if.pready_8),
    .pslverr_8(_if.pslverr_8),
    // apb slvae_9
    .psel_9(_if.psel_9),
    .prdata_9(_if.prdata_9),
    .pready_9(_if.pready_9),
    .pslverr_9(_if.pslverr_9),
    // apb slvae_10
    .psel_10(_if.psel_10),
    .prdata_10(_if.prdata_10),
    .pready_10(_if.pready_10),
    .pslverr_10(_if.pslverr_10),
    // apb slvae_11
    .psel_11(_if.psel_11),
    .prdata_11(_if.prdata_11),
    .pready_11(_if.pready_11),
    .pslverr_11(_if.pslverr_11)
);
    
endmodule