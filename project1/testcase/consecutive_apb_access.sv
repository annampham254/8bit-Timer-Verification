class consecutive_apb_access extends base_test;

    function new();
        super.new();
    endfunction
    
    virtual task run_scenario();
    bit[7:0] rdata;

    repeat (1) begin

    $display("====================TEST 5=====================");
    write(8'h0,8'b1);
    write(8'h1,8'b11);
    write(8'h2,8'd25);
    write(8'h3,8'b11);

    read(8'h0,rdata);
    check(rdata,8'b1);
    read(8'h1,rdata);
    check(rdata,8'b0);
    read(8'h2,rdata);
    check(rdata,8'd25);
    read(8'h3,rdata);
    check(rdata,8'b11);
$display("\033[1;36m#                                TEST 5 \033[0m");
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;
    
    end

    endtask

endclass
