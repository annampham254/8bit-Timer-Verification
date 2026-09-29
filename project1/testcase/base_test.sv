class base_test;
environment envi;
virtual dut_if dut_vif;

int error_cnt;

    function new();
    endfunction

    function void build();
        envi = new(dut_vif);
        envi.build();
    endfunction

    task check(bit[7:0]act_val, bit[7:0]exp_val);
        if(act_val == exp_val)begin
            $display("\033[32m#%0t: PASSED Data matching actual = %0h expect = %0h\033[0m",$time,act_val,exp_val);
        end else begin
            $display("\033[31m#%0t: FAILED Data not matching actual = %0h expect = %0h\033[0m",$time,act_val,exp_val);
            error_cnt++;
        end
    endtask

    task write(bit[7:0] addr, bit[7:0]wdata);
        packet pkt = new();
        pkt.transfer = packet::WRITE;
        pkt.addr = addr;
        pkt.data = wdata;
        envi.sti.send_pkt(pkt);
        @(envi.dri.xfer_done);
    endtask

    task read(bit[7:0] addr,ref bit[7:0]rdata);
        packet pkt = new();
        pkt.transfer = packet::READ;
        pkt.addr = addr;
        envi.sti.send_pkt(pkt);
        @(envi.dri.xfer_done);
        rdata = pkt.data;
    endtask

    task write_random(bit[7:0] addr_in, ref bit[7:0]wdata_use);
        packet pkt = new();
        assert(pkt.randomize() with {
            pkt.transfer == packet::WRITE;
            pkt.addr == addr_in;
        }) else $display("RANDOM FAIL");
        wdata_use = pkt.data;
        envi.sti.send_pkt(pkt);
        @(envi.dri.xfer_done);
    endtask

    function automatic int cal_clk ( //use wwhen counter=0
        bit count_down,
        bit load,
        bit [7:0] tdr_val,
        bit [1:0] clk_div
    );
        int device_temp;
        int device;
        int steps;
        bit [7:0]tdr;
        
        tdr = load? tdr_val:8'b0;

        case(clk_div)
            2'b00: device = 1;
            2'b01: device = 2;
            2'b10: device = 4;
            2'b11: device = 8;
            default: device = 1;
        endcase

        if (count_down)begin 
            steps = tdr + 1;
        end else begin 
            steps = 256 - tdr;
        end
        cal_clk = steps*device + 5;//bias = 5;
    endfunction

    virtual task run_scenario();
    endtask

    task run();
        build();
        fork
           run_scenario();
           envi.run();
        join_any
    #1us;
    envi.sb.report(error_cnt);
    $display("%0t: [base_test] End simulation",$time);
    $finish;
    endtask

endclass
