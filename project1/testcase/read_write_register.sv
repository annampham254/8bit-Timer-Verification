class read_write_register extends base_test;

    function new();
        super.new();
    endfunction
    
    virtual task run_scenario();
    bit[7:0] rdata;
    bit[7:0] data_write_random;
    bit[7:0] exp_val_tcr;
    bit[7:0] exp_val_tie;

    repeat (1) begin

    write_random(8'h0,data_write_random);
    read(8'h0,rdata);
    exp_val_tcr = {3'h0,data_write_random[4:0]};
    check(rdata,exp_val_tcr);
    write(8'h0,8'h0);

    write(8'h1,8'b11);
    read(8'h1,rdata);
    check(rdata,8'b0);

    write_random(8'h2,data_write_random);
    read(8'h2,rdata);
    check(rdata,data_write_random);

    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;

    write_random(8'h3,data_write_random);
    read(8'h3,rdata);
    exp_val_tie = {5'h0,data_write_random[1:0]};
    check(rdata,exp_val_tie);
$display("\033[1;36m#                                TEST 2 \033[0m");
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;
    
    end

    endtask

endclass
