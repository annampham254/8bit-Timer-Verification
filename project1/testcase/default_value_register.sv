class default_value_register extends base_test;

    function new();
        super.new();
    endfunction

    virtual task run_scenario();
        bit[7:0] rdata;
        wait(dut_vif.presetn == 1);
        read(8'h0,rdata);
        check(rdata,8'b0);
        read(8'h1,rdata);
        check(rdata,8'b0);
        read(8'h2,rdata);
        check(rdata,8'b0);
        read(8'h3,rdata);
        check(rdata,8'b0);
        $display("\033[1;36m#                                TEST 1 \033[0m");
    endtask

endclass
