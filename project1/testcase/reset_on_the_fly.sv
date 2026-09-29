class reset_on_the_fly extends base_test;

    function new();
        super.new();
    endfunction
    
    virtual task run_scenario();
    bit[7:0] rdata;
    bit[7:0] data_write_random;
    bit[7:0] exp_val_tcr;
    bit[7:0] exp_val_tie;

    repeat (1) begin

    $display("====================TEST 3=====================");
    write(8'h0,8'b1101);
    write(8'h1,8'b11);
    write(8'h2,8'd32);
    write(8'h3,8'b11);

    repeat (5) @(posedge dut_vif.ker_clk);
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;

    read(8'h0,rdata);
    check(rdata,8'h0);
    read(8'h1,rdata);
    check(rdata,8'h0);
    read(8'h2,rdata);
    check(rdata,8'h0);
    read(8'h3,rdata);
    check(rdata,8'h0);
 $display("\033[1;36m#                                TEST 3 \033[0m");  
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;
    
    end

    endtask

endclass
