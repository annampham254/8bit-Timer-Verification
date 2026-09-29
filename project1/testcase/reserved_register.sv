class reserved_register extends base_test;

    function new();
        super.new();
    endfunction
    
    virtual task run_scenario();
    bit[7:0] rdata;
    bit[7:0] data_write_random;
    bit[7:0] exp_val_tcr;
    bit[7:0] exp_val_tie;

    repeat (1) begin

    $display("====================TEST 4=====================");
    write_random(8'h5,data_write_random);
    write_random(8'h6,data_write_random);
    write_random(8'h7,data_write_random);
    write_random(8'h8,data_write_random);
    write_random(8'h9,data_write_random);
    write_random(8'h10,data_write_random);

    read(8'h5,rdata);
    check(rdata,8'h0);
    read(8'h6,rdata);
    check(rdata,8'h0);
    read(8'h7,rdata);
    check(rdata,8'h0);
    read(8'h8,rdata);
    check(rdata,8'h0);
    read(8'h9,rdata);
    check(rdata,8'h0);
    read(8'h10,rdata);
    check(rdata,8'h0);
$display("\033[1;36m#                                TEST 4 \033[0m");
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;
    
    end

    endtask

endclass
