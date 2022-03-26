// transaction from AHB to APB
class TRANS;

    rand bit [31:0] data;   // write data to APB OR read data from APB  
    rand bit [31:0] addr;   // APB slave address
    bit dir;                // 1 for write and 0 for read
    bit error;              // 1 for APB response error and 0 for APB response success
    int delay;              // APB response delay
    int index;              // APB slave index
    
    
    // address constraint
    constraint c_addr {
        soft (index == 0) -> addr inside {[32'h0000_0400 : 32'h0000_07ff]};
        soft (index == 1) -> addr inside {[32'h0000_0800 : 32'h0000_0bff]};
        soft (index == 2) -> addr inside {[32'h0000_0c00 : 32'h0000_0fff]};
        soft (index == 3) -> addr inside {[32'h0000_1000 : 32'h0000_13ff]};
        soft (index == 4) -> addr inside {[32'h0000_1400 : 32'h0000_17ff]};
        soft (index == 5) -> addr inside {[32'h0000_1800 : 32'h0000_1bff]};
        soft (index == 6) -> addr inside {[32'h0000_1c00 : 32'h0000_1fff]};
        soft (index == 7) -> addr inside {[32'h0000_2000 : 32'h0000_23ff]};
        soft (index == 8) -> addr inside {[32'h0000_2400 : 32'h0000_27ff]};
        soft (index == 9) -> addr inside {[32'h0000_2800 : 32'h0000_2bff]};
        soft (index == 10) -> addr inside {[32'h0000_2c00 : 32'h0000_2fff]};
        soft (index == 11) -> addr inside {[32'h0000_3000 : 32'h0000_33ff]};
    }
    
    function new(bit dir=1, bit error=0, int delay=0, int index=0);
        this.dir = dir;
        this.error = error;
        this.delay = delay;
        this.index = index;
    endfunction 
endclass

TRANS trans;

// display task name
function void display_name(string name);
    $display("Starting    %s task !!!", name);
endfunction

task ahb_next();
    while (1) begin
        @(posedge i_apb_if.hclk)
        if(i_apb_if.hreadyout == 1'b1) break;
    end
endtask

/*
* name : transfer one write transaction with defalut set
*
* description : AHB bus write transaction to APB slave 0 without APB response delay
* 
*/
task one_write_trans_defalut();
    // TRANS object
    trans = new(.dir(1), .error(0), .delay(0), .index(0));
    // TRANS randomize
    initialize_trans:assert (trans.randomize())
        else $error("TRANS randomize failed!");

    display_name("one_write_trans_defalut");

    fork
        // AHB master 
        begin
            // address phase
            ahb_next();
            i_apb_if.haddr  = trans.addr;
            i_apb_if.hwrite = trans.dir;
    
            i_apb_if.hready = 1'b1;
            i_apb_if.hsel   = 1'b1;
            i_apb_if.htrans = 2'b10;
            i_apb_if.hsize  = 3'b010;
            i_apb_if.hburst = 3'b000;
            
            // data phase
            ahb_next();
            i_apb_if.hwdata = trans.data;
            i_apb_if.htrans = 2'b00;
            
            // end phase
            ahb_next();
            i_apb_if.hready = 1'b0;
            i_apb_if.hsel   = 1'b0;
            i_apb_if.htrans = 2'bx;
            i_apb_if.hsize  = 3'bx;
            i_apb_if.hburst = 3'bx;
        end

        // APB slave 0
        begin
            wait(i_apb_if.penable == 1'b1 && i_apb_if.psel_0 == 1'b1)
            i_apb_if.pready_0  = 1'b1;
            i_apb_if.pslverr_0 = 1'b0;

            @(posedge i_apb_if.hclk)
            i_apb_if.pready_0  = 1'b0;
        end
    join

    #100;

endtask

/*
* name : transfer one read transaction with default set
*
* description :  AHB bus read transaction to APB slave 0 without APB response delay
*/
task one_read_trans_defalut();
    // TRANS object
    trans = new(.dir(0), .error(0), .delay(0), .index(0));
    // TRANS randomize
    initialize_trans:assert (trans.randomize())
        else $error("TRANS randomize failed!");
    display_name("one_read_trans_defalut");

    fork
        // AHB master 
        begin
            // address phase
            ahb_next();
            i_apb_if.haddr  = trans.addr;
            i_apb_if.hwrite = trans.dir;
    
            i_apb_if.hready = 1'b1;
            i_apb_if.hsel   = 1'b1;
            i_apb_if.htrans = 2'b10;
            i_apb_if.hsize  = 3'b010;
            i_apb_if.hburst = 3'b000;
            
            // data phase
            ahb_next();
            i_apb_if.htrans = 2'b00;
            
            // end phase
            ahb_next();
            i_apb_if.hready = 1'b0;
            i_apb_if.hsel   = 1'b0;
            i_apb_if.htrans = 2'bx;
            i_apb_if.hsize  = 3'bx;
            i_apb_if.hburst = 3'bx;
        end

        // APB slave 0
        begin
            wait(i_apb_if.penable == 1'b1 && i_apb_if.psel_0 == 1'b1)
            i_apb_if.pready_0  = 1'b1;
            i_apb_if.pslverr_0 = 1'b0;
            i_apb_if.prdata_0  = trans.data;

            @(posedge i_apb_if.hclk)
            i_apb_if.pready_0  = 1'b0;
        end
    join

    #100;
endtask




