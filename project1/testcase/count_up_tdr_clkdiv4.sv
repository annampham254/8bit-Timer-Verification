class  count_up_tdr_clkdiv4 extends base_test;

    function new();
        super.new();
    endfunction

    virtual task run_scenario();
    bit[7:0] rdata;
    bit[7:0] tdr_val;
    int clk_step;
    write(8'h3,8'b11);
    write_random(8'h2,tdr_val);
    write(8'h0,8'b00100);
    write(8'h0,8'b10001);
        
    clk_step = cal_clk(1'b0,1'b1,tdr_val,2'b10);//(cnt_down,load,tdr_val,clk_div)
    
    repeat (clk_step) @(posedge dut_vif.ker_clk);

    check(dut_vif.interrupt,1'b1);
    write(8'b1,8'b1);    
    
    repeat (5) @(posedge dut_vif.pclk);
    read(8'b1,rdata);
    check(rdata,8'b0);
    check(dut_vif.interrupt,1'b0);
 $display("\033[1;36m#                                TEST 34 \033[0m");  
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;
    
    
    endtask
endclass
