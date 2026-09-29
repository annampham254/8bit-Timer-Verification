class scoreboard;
mailbox #(packet) m2s_mb;
packet pkt;
int error_cnt;

   covergroup CVG;
        apb_transfer: coverpoint pkt.transfer{
            bins apb_read = {packet::READ};
            bins apb_write = {packet::WRITE};
        } 
        apb_addr: coverpoint pkt.addr{
            bins TCR_addr = {8'h0};
            bins TSR_addr = {8'h1};
            bins TDR_addr = {8'h2};
            bins TIE_addr = {8'h3};
            bins reserved_addr = default;
        }
        //TCR
        timer_en: coverpoint pkt.data[0] iff(pkt.transfer == packet::WRITE && pkt.addr == 8'h0){
            bins timer_ena =  {1'b1};
            bins timer_dis =  {1'b0};
        }
        count_down: coverpoint pkt.data[1] iff(pkt.transfer == packet::WRITE && pkt.addr == 8'h0){
            bins counter_up =   {1'b0};
            bins counter_down = {1'b1};
        }
        load: coverpoint pkt.data[2] iff(pkt.transfer == packet::WRITE && pkt.addr == 8'h0){
            bins load_en =  {1'b1};
            bins load_dis = {1'b0};
        }
        clk_div: coverpoint pkt.data[4:3] iff(pkt.transfer == packet::WRITE && pkt.addr == 8'h0){
            bins no_div = {2'b00};
            bins div2 =   {2'b01};
            bins div4 =   {2'b10};
            bins div8 =   {2'b11};
        }
        //TSR
        overflow_status: coverpoint pkt.data[0] iff(pkt.transfer == packet::READ && pkt.addr == 8'h1){
            bins overflow_trigger     =  {1'b1};
            bins overflow_not_trigger =  {1'b0};
        }
        underflow_status: coverpoint pkt.data[1] iff(pkt.transfer == packet::READ && pkt.addr == 8'h1){
            bins underflow_trigger     =  {1'b1};
            bins underflow_not_trigger =  {1'b0};
        }
        clear_interrupt: coverpoint pkt.data[1:0] iff(pkt.transfer == packet::WRITE && pkt.addr == 8'h1){
            bins overflow_clear       =  {2'b01};
            bins underflow_clear      =  {2'b10};
        }
        //TDR
        data_TDR: coverpoint pkt.data iff(pkt.transfer == packet::WRITE && pkt.addr == 8'h2){
            bins TDR_min = {8'h0};
            bins TDR_max = {8'hFF};
            bins others =  {[8'h1:8'hFE]};
        }
        //TIE
        overflow_en: coverpoint pkt.data[0] iff(pkt.transfer == packet::WRITE && pkt.addr == 8'h3){
            bins overflow_ena =  {1'b1};
            bins overflow_dis = {1'b0};
        }
        underflow_en: coverpoint pkt.data[1] iff(pkt.transfer == packet::WRITE && pkt.addr == 8'h3){
            bins underflow_ena =  {1'b1};
            bins underflow_dis = {1'b0};
        }
        //CROSSSSSSSSSSSSS
        apb_transaction: cross apb_transfer,apb_addr;
        //COUNT UP/DOWN
        count_up_down_feature: cross apb_transfer,apb_addr,timer_en,count_down{ 
            ignore_bins counter_up_down = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TCR_addr) || !binsof(timer_en.timer_ena) || !binsof(count_down);
        }
        //COUNT UP/DOWN WITH CLK_DIV
        count_with_clkdiv_feature: cross apb_transfer,apb_addr,timer_en,count_down,clk_div{ 
            ignore_bins counter_up_down_with_clkdiv = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TCR_addr) || !binsof(timer_en.timer_ena) || !binsof(count_down) || !binsof(clk_div);
        }
        //LOAD DATA TDR
        set_data_TDR_to_counter_feature: cross apb_transfer,apb_addr,data_TDR{ 
            ignore_bins setup_TDR = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TDR_addr)  || !binsof(data_TDR);            
        }
        //SET UP LOAD 1 IN TCR
        set_TCR_load1_feature: cross apb_transfer,apb_addr,timer_en,load{         
            ignore_bins setup_TCR_load1           = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TCR_addr) || !binsof(timer_en.timer_dis) || !binsof(load.load_en) ;//tcr load = 1 
        }
        //SET UP LOAD 0 IN TCR
        set_TCR_load0_feature: cross apb_transfer,apb_addr,timer_en,load{                     
            ignore_bins count_with_data_TDR = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TCR_addr) || !binsof(timer_en.timer_ena) || !binsof(load.load_dis);//tcr load = 0
        }
        //COUNT UP/DOWN WITH TDR AND CLK_DIV
        count_with_tdr_clkdiv_feature: cross apb_transfer,apb_addr,timer_en,count_down,clk_div,load{ 
            ignore_bins counter_up_down_with_tdr_clkdiv = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TCR_addr) || !binsof(timer_en.timer_ena)|| !binsof(load.load_dis)
                                                                                          || !binsof(count_down) || !binsof(clk_div);
        }
        //SET ENABLE OVERFLOW
        set_enable_overflow_feature: cross apb_transfer,apb_addr,overflow_en{
            ignore_bins overflow_enable_disable  = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TIE_addr) || !binsof(overflow_en);//enable/dissable overflow
        }
        //SET ENABLE UNDERFLOW
        set_enable_underflow_feature: cross apb_transfer,apb_addr,underflow_en{ 
            ignore_bins underflow_enable_disable = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TIE_addr) || !binsof(underflow_en);//enable/dissable underflow
        }
        //OVERFLOW STATUS TRIGGER INTERRUPT
        over_trigger_feature: cross apb_transfer,apb_addr,overflow_status{ 
            ignore_bins ovflow_trigger     = !binsof(apb_transfer.apb_read) || !binsof(apb_addr.TSR_addr) || !binsof(overflow_status);//overflow trigger/not trigger
        } 
        //UNDERFLOW STATUS TRIGGER INTERRUPT
        under_trigger_feature: cross apb_transfer,apb_addr,underflow_status{ 
            ignore_bins unflow_trigger     = !binsof(apb_transfer.apb_read) || !binsof(apb_addr.TSR_addr) || !binsof(underflow_status);//underflow trigger/not trigger
        }
        //CLEAR OVERFLOW INTERRUPT
        clear_overflow_interrupt_feature: cross apb_transfer,apb_addr,clear_interrupt{ 
            ignore_bins ovflow_clear      = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TSR_addr) || !binsof(clear_interrupt.overflow_clear);  // clear overflow     
        }
        //CLEAR UNDERFLOW INTERRUPT
        clear_underflow_interrupt_feature: cross apb_transfer,apb_addr,clear_interrupt{ 
            ignore_bins unflow_clear      = !binsof(apb_transfer.apb_write) || !binsof(apb_addr.TSR_addr) || !binsof(clear_interrupt.underflow_clear);  // clear underflow
        }
    
    endgroup

    function new(mailbox #(packet) m2s_mb);
        this.m2s_mb = m2s_mb;
        CVG = new();
    endfunction

    function void report(int error_cnt);
        int total_error;
        total_error = this.error_cnt + error_cnt;
        if(total_error == 0)begin
            $display("\033[1;32m#%0t:[SCOREBOARD]==========> TEST_PASS \033[0m",$time);
        end else begin
            $display("\033[1;31m#%0t:[SCOREBOARD]==========> TEST_FAIL!!!!  NUMBER OF ERROR = %0D \033[0m",$time,total_error);
        end
    endfunction

    task run();
        //packet pkt;
        while(1)begin
            m2s_mb.get(pkt);
            $display("\033[36m#%0t:[SCOREBOARD] Get packet from monitor %s with address %0h and data %0h \033[0m",$time,pkt.transfer.name(),pkt.addr,pkt.data);
            CVG.sample();
        end
    endtask

    

endclass
