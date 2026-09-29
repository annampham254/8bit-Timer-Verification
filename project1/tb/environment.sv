class environment;
stimulus sti;
driver dri;
monitor mon;
scoreboard sb;
virtual dut_if dut_vif;
mailbox #(packet) s2d_mb;
mailbox #(packet) m2s_mb;
    
    function new(virtual dut_if dut_vif);
        this.dut_vif = dut_vif;    
    endfunction

    function void build();
        $display("%0t:[ENVIRONMENT] build",$time);
        s2d_mb = new();
        m2s_mb = new();
        sti = new(s2d_mb);
        dri = new(s2d_mb,dut_vif);
        mon = new(m2s_mb,dut_vif);
        sb  = new(m2s_mb);
    endfunction

    task run();
        fork
        sti.run();
        dri.run();
        mon.run();
        sb.run();
        join
    endtask
 
endclass
