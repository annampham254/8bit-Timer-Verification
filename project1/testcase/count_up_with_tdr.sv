class count_up_with_tdr extends base_test;

    function new();
        super.new();
    endfunction
    
    virtual task run_scenario();
    bit[7:0] rdata;
    repeat (1) begin

        $display("====================TEST 13=====================");
    write(8'h3,8'b1);
    write(8'h2,8'd100);
    write(8'h0,8'b00100);
    write(8'h0,8'b00001);

    repeat (165) @(posedge dut_vif.ker_clk);
    
    read(8'h1,rdata);
    check(dut_vif.interrupt,1'b1);
    write(8'h1,8'b1);
     
$display("\033[1;36m#                                TEST 13 \033[0m");
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;
    
    end

    endtask

endclass
