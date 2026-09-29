class count_down_stop_load_down extends base_test;

    function new();
        super.new();
    endfunction
    
    virtual task run_scenario();
    bit[7:0] rdata;
   
    repeat (1) begin
    write(8'h3,8'b11);
    write(8'h2,8'd200);
    write(8'h0,8'b100);
    write(8'h0,8'b11);
    repeat (50) @(posedge dut_vif.ker_clk);
    write (8'h0,8'b0);
    repeat (20) @(posedge dut_vif.ker_clk);
    write(8'h2,8'd60);
    write(8'h0,8'b100);
    write(8'h0,8'b11);
    repeat (65) @(posedge dut_vif.ker_clk);
    check(dut_vif.interrupt,1'b1);
    write (8'h1,8'b10);
    

    $display("\033[1;36m#                                TEST 44 \033[0m");
    dut_vif.presetn = 1'b0;
    #10ns; dut_vif.presetn = 1'b1;
    
    end

    endtask

endclass
