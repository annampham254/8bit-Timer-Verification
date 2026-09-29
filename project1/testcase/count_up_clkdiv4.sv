class count_up_clkdiv4 extends base_test;

    function new();
        super.new();
    endfunction

    virtual task run_scenario();
    bit[7:0] rdata;
    
    repeat (1) begin
    write(8'h3,8'b01);
    write(8'h0,8'b10001);

    repeat (1029) @(posedge dut_vif.ker_clk);
    
    check(dut_vif.interrupt,1'b1);
    write(8'b1,8'b1);

    repeat (5) @(posedge dut_vif.pclk);
    read(8'b1,rdata);
    check(rdata,8'b0);
    check(dut_vif.interrupt,1'b0);

    
 $display("\033[1;36m#                                TEST 26 \033[0m");  
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;
    
    end

    endtask
endclass
