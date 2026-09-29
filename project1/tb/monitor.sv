class monitor;
mailbox #(packet) m2s_mb;
virtual dut_if dut_vif;

    function new(mailbox #(packet) m2s_mb,virtual dut_if dut_vif);
        this.m2s_mb = m2s_mb;
        this.dut_vif = dut_vif;
    endfunction

    task run();
        packet pkt;
        while(1)begin
            @(posedge dut_vif.pclk);#1;
            wait(dut_vif.psel == 1'b1 && dut_vif.penable == 1'b1)begin
                if(dut_vif.pwrite == 1'b1)begin
                   pkt = new();
                   pkt.transfer = packet::WRITE;
                   pkt.addr = dut_vif.paddr;
                   pkt.data = dut_vif.pwdata;
                end else begin
                   pkt = new();
                   pkt.transfer = packet::READ;
                   pkt.addr = dut_vif.paddr;
                   pkt.data = dut_vif.prdata;
                end
                $display("%0t:[MONITOR] %s with address %0h and data %0h ",$time,pkt.transfer.name(),pkt.addr,pkt.data);
                m2s_mb.put(pkt);
                $display("%0t:[MONITOR] Send packet to mailbox",$time);
            end
        end
    endtask

endclass
