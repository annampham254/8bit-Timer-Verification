class driver;
mailbox #(packet) s2d_mb;
virtual dut_if dut_vif;
event xfer_done;

    function new(mailbox #(packet) s2d_mb,virtual dut_if dut_vif);
        this.s2d_mb = s2d_mb;
        this.dut_vif = dut_vif;
    endfunction

    task run();
        packet pkt;
        wait(dut_vif.presetn);
        while(1)begin
            s2d_mb.get(pkt);

            if(pkt.transfer == packet::WRITE)begin
                $display("%0t:[DRIVER]APB WRITE",$time);
                write(pkt);
                ->xfer_done;
            end else begin
                $display("%0t:[DRIVER]APB READ",$time);
                read(pkt);
                ->xfer_done;
            end
        end
    endtask

    task write(packet pkt);
        @(posedge dut_vif.pclk);#1;
        dut_vif.pwrite = 1'b1;
        dut_vif.psel = 1'b1;
        dut_vif.paddr = pkt.addr;
        dut_vif.pwdata = pkt.data;

        @(posedge dut_vif.pclk);#1;
        dut_vif.penable = 1'b1;
        
        @(posedge dut_vif.pclk);
        dut_vif.pwrite = 1'b0;
        dut_vif.psel = 1'b0;
        dut_vif.penable = 1'b0;
        dut_vif.paddr = 8'h0;
        dut_vif.pwdata = 8'h0;
    endtask

    task read(packet pkt);
        @(posedge dut_vif.pclk);#1;
        dut_vif.pwrite = 1'b0;
        dut_vif.psel = 1'b1;
        dut_vif.paddr = pkt.addr;

        @(posedge dut_vif.pclk);#1;
        dut_vif.penable = 1'b1;
        pkt.data = dut_vif.prdata;
        
        @(posedge dut_vif.pclk);
        dut_vif.pwrite = 1'b0;
        dut_vif.psel = 1'b0;
        dut_vif.penable = 1'b0;
        dut_vif.paddr = 8'h0;
    endtask

endclass
