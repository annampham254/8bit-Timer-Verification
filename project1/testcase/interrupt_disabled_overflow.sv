class interrupt_disabled_overflow extends base_test;

    function new();
        super.new();
    endfunction

    virtual task run_scenario();
    bit[7:0] rdata;
    
    repeat (1) begin 
    write(8'h0,8'b01);

    repeat (261) @(posedge dut_vif.ker_clk);
    read(8'b1,rdata);
    check(rdata,8'b1);
    check(dut_vif.interrupt,1'b0);

    
 $display("\033[1;36m#                                TEST 20 \033[0m");  
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;
    
    end

    endtask
endclass
