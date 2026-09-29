class df_test extends base_test;

    function new();
        super.new();
    endfunction

    virtual task run_scenario();
        bit[7:0] rdata;
        bit[7:0] tdr_val;
        int clk_step;
        write(8'h3,8'b11);
        write_random(8'h2,tdr_val);
        write(8'h0,8'b100);
        write(8'h0,8'b001);
        
        clk_step = cal_clk(1'b0,1'b1,tdr_val,2'b0);
        $display("KER CLK = %0d",clk_step);
        repeat(clk_step) @(posedge dut_vif.ker_clk);
        read(8'h01,rdata);
        $display("%0b",dut_vif.interrupt);
        
    endtask

endclass
