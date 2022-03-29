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

    function void display();
        string s;
        s={s,$sformatf("=======================================================\n")};
        s={s,$sformatf("               addr : %8h\n", this.addr)};
        s={s,$sformatf("               data : %8h\n", this.data)};
        s={s,$sformatf("          direction : %s\n", this.dir ? "write" : "read ")};
        s={s,$sformatf("           response : %s\n", this.error ? "fail   " : "success")};
        s={s,$sformatf("  apb response delay: %0d\n", this.delay)};
        s={s,$sformatf("     apb slave index: %0d\n", this.index)};
        s={s,$sformatf("=======================================================\n")};
        $display("%s",s);
    endfunction

endclass

TRANS trans;
TRANS trans_lits [];

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

task ahb_begin();
    i_apb_if.hready = 1'b1;
    i_apb_if.hsel   = 1'b1;
    i_apb_if.hsize  = 3'b010;
    i_apb_if.hburst = 3'b000;
endtask

task ahb_end();
    i_apb_if.hready = 1'b0;
    i_apb_if.hsel   = 1'b0;
    i_apb_if.hsize  = 3'bx;
    i_apb_if.hburst = 3'bx;
endtask

task apb_pready(int index, bit value);
    if(index == 0) 
        i_apb_if.pready_0 = value;
    else if(index == 1)
        i_apb_if.pready_1 = value;
    else if(index == 2)
        i_apb_if.pready_2 = value;
    else if(index == 3)
        i_apb_if.pready_3 = value;
    else if(index == 4)
        i_apb_if.pready_4 = value;
    else if(index == 5)
        i_apb_if.pready_5 = value;
    else if(index == 6)
        i_apb_if.pready_6 = value;
    else if(index == 7)
        i_apb_if.pready_7 = value;
    else if(index == 8)
        i_apb_if.pready_8 = value;
    else if(index == 9)
        i_apb_if.pready_9 = value;
    else if(index == 10)
        i_apb_if.pready_10 = value;
    else if(index == 11)
        i_apb_if.pready_11 = value;
endtask

task apb_pslverr(int index, bit value);
    if(index == 0) 
        i_apb_if.pslverr_0 = value;
    else if(index == 1)
        i_apb_if.pslverr_1 = value;
    else if(index == 2)
        i_apb_if.pslverr_2 = value;
    else if(index == 3)
        i_apb_if.pslverr_3 = value;
    else if(index == 4)
        i_apb_if.pslverr_4 = value;
    else if(index == 5)
        i_apb_if.pslverr_5 = value;
    else if(index == 6)
        i_apb_if.pslverr_6 = value;
    else if(index == 7)
        i_apb_if.pslverr_7 = value;
    else if(index == 8)
        i_apb_if.pslverr_8 = value;
    else if(index == 9)
        i_apb_if.pslverr_9 = value;
    else if(index == 10)
        i_apb_if.pslverr_10 = value;
    else if(index == 11)
        i_apb_if.pslverr_11 = value;
endtask

task apb_prdata(int index, bit [31:0] value);
    if(index == 0) 
        i_apb_if.prdata_0 = value;
    else if(index == 1)
        i_apb_if.prdata_1 = value;
    else if(index == 2)
        i_apb_if.prdata_2 = value;
    else if(index == 3)
        i_apb_if.prdata_3 = value;
    else if(index == 4)
        i_apb_if.prdata_4 = value;
    else if(index == 5)
        i_apb_if.prdata_5 = value;
    else if(index == 6)
        i_apb_if.prdata_6 = value;
    else if(index == 7)
        i_apb_if.prdata_7 = value;
    else if(index == 8)
        i_apb_if.prdata_8 = value;
    else if(index == 9)
        i_apb_if.prdata_9 = value;
    else if(index == 10)
        i_apb_if.prdata_10 = value;
    else if(index == 11)
        i_apb_if.prdata_11 = value;
endtask

task apb_wait_psel(int index);
    if(index == 0)
        wait(i_apb_if.psel_0 == 1'b1);
    else if (index == 1)
        wait(i_apb_if.psel_1 == 1'b1);
    else if (index == 2)
        wait(i_apb_if.psel_2 == 1'b1);
    else if (index == 3)
        wait(i_apb_if.psel_3 == 1'b1);
    else if (index == 4)
        wait(i_apb_if.psel_4 == 1'b1);
    else if (index == 5)
        wait(i_apb_if.psel_5 == 1'b1);
    else if (index == 6)
        wait(i_apb_if.psel_6 == 1'b1);
    else if (index == 7)
        wait(i_apb_if.psel_7 == 1'b1);
    else if (index == 8)
        wait(i_apb_if.psel_8 == 1'b1);
    else if (index == 9)
        wait(i_apb_if.psel_9 == 1'b1);
    else if (index == 10)
        wait(i_apb_if.psel_10 == 1'b1);
    else if (index == 11)
        wait(i_apb_if.psel_11 == 1'b1);
endtask

/*
* name : transfer one write transaction with defalut set
*
* description : A AHB bus write transaction to APB slave 0 without APB response delay
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
            ahb_begin();

            // address phase
            ahb_next();
            i_apb_if.haddr  = trans.addr;
            i_apb_if.hwrite = trans.dir;

            i_apb_if.htrans = 2'b10;
            
            // data phase
            ahb_next();
            i_apb_if.hwdata = trans.data;
            i_apb_if.htrans = 2'b00;
            
            // end phase
            ahb_next();
            i_apb_if.htrans = 2'bx;

            ahb_end();
        end

        // APB slave 0
        begin
            apb_wait_psel(0);
            wait(i_apb_if.penable == 1'b1);
            apb_pready(0, 1);
            apb_pslverr(0, 0);

            @(posedge i_apb_if.hclk)
            apb_pready(0, 0);
        end
    join

    #100;

endtask

/*
* name : transfer one read transaction with default set
*
* description :  A AHB bus read transaction to APB slave 0 without APB response delay
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
            ahb_begin();

            // address phase
            ahb_next();
            i_apb_if.haddr  = trans.addr;
            i_apb_if.hwrite = trans.dir;
    
            i_apb_if.htrans = 2'b10;
            
            // data phase
            ahb_next();
            i_apb_if.htrans = 2'b00;
            
            // end phase
            ahb_next();
            i_apb_if.htrans = 2'bx;

            ahb_end();
        end

        // APB slave 0
        begin
            apb_wait_psel(0);
            wait(i_apb_if.penable == 1'b1);
            apb_pready(0, 1);
            apb_pslverr(0, 0);
            apb_prdata(0, trans.data);

            @(posedge i_apb_if.hclk);
            apb_pready(0, 0);
        end
    join

    #100;
endtask

/*
* name : transfer write transactions 
*
* description :  AHB write transactions to designative APB slave with designative response delay.
*                The response is success or error randomly.
*/
task write_trans(int nums, int index, int max_delay);
    // TRANS list
    trans_lits = new[nums];
    // TRANS randomize
    for (int i = 0 ; i < $size(trans_lits) ; i++) begin
        TRANS trans_temp;
        trans_temp = new(.dir(1), .error({$random()}%2), .delay({$random()}%(max_delay+1)), .index(index));
        initialize_trans:assert (trans_temp.randomize())
            else $error("TRANS randomize failed!");
        trans_lits[i] = trans_temp;

        $display("%d",i);
        trans_lits[i].display();
    end

    display_name("write_trans");

    fork
        // AHB master 
        begin
            ahb_begin();

            for (int i = 0 ; i < $size(trans_lits) ; i++) begin
                ahb_next();
                i_apb_if.haddr  = trans_lits[i].addr;
                i_apb_if.hwrite = trans_lits[i].dir;
                i_apb_if.htrans = 2'b10;
                if (i != 0) begin
                    i_apb_if.hwdata = trans_lits[i-1].data;
                end
            end

            ahb_next();
            i_apb_if.hwdata = trans_lits[$size(trans_lits)-1].data;
            i_apb_if.htrans = 2'b00;

            ahb_next();
            i_apb_if.htrans = 2'bx;

            ahb_end();
        end

        // APB slave
        begin
            for (int i = 0 ; i < $size(trans_lits) ; i++) begin
                apb_wait_psel(index);
                wait(i_apb_if.penable == 1'b1);

                apb_pready(index, 0);
                apb_pslverr(index, 0);

                repeat(trans_lits[i].delay) begin
                    @(posedge i_apb_if.hclk);
                end

                apb_pready(index, 1);
                apb_pslverr(index, trans_lits[i].error);
            
                @(posedge i_apb_if.hclk);
                apb_pready(index, 0);
                apb_pslverr(index, 0);

                @(posedge i_apb_if.hclk);
            end
        end

    join

    #100;
endtask

/*
* name : transfer read transactions 
*
* description :  AHB read transactions to designative APB slave with designative response delay.
*                The response is success or error randomly.
*/
task read_trans(int nums, int index, int max_delay);
    // TRANS list
    trans_lits = new[nums];
    // TRANS randomize
    for (int i = 0 ; i < $size(trans_lits) ; i++) begin
        TRANS trans_temp;
        trans_temp = new(.dir(0), .error({$random()}%2), .delay({$random()}%(max_delay+1)), .index(index));
        initialize_trans:assert (trans_temp.randomize())
            else $error("TRANS randomize failed!");
        trans_lits[i] = trans_temp;

        $display("%d",i);
        trans_lits[i].display();
    end

    display_name("read_trans");

    fork
        // AHB master 
        begin
            ahb_begin();

            for (int i = 0 ; i < $size(trans_lits) ; i++) begin
                ahb_next();
                i_apb_if.haddr  = trans_lits[i].addr;
                i_apb_if.hwrite = trans_lits[i].dir;
                i_apb_if.htrans = 2'b10;
            end

            ahb_next();
            i_apb_if.htrans = 2'b00;

            ahb_next();
            i_apb_if.htrans = 2'bx;

            ahb_end();
        end

        // APB slave
        begin
            for (int i = 0 ; i < $size(trans_lits) ; i++) begin
                apb_wait_psel(index);
                wait(i_apb_if.penable == 1'b1);

                apb_pready(index, 0);
                apb_pslverr(index, 0);

                repeat(trans_lits[i].delay) begin
                    @(posedge i_apb_if.hclk);
                end

                apb_pready(index, 1);
                apb_pslverr(index, trans_lits[i].error);
                apb_prdata(index, trans_lits[i].data);
            
                @(posedge i_apb_if.hclk);
                apb_pready(index, 0);
                apb_pslverr(index, 0);

                @(posedge i_apb_if.hclk);
            end
        end

    join

    #100;
endtask