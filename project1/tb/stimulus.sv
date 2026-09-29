class stimulus;
mailbox #(packet) s2d_mb;
packet queue_pkt[$];

    function new(mailbox #(packet) s2d_mb);
        this.s2d_mb = s2d_mb;
    endfunction

    task send_pkt(packet pkt);
        queue_pkt.push_front(pkt);
    endtask

    task run();
        packet pkt;
        while(1)begin
            wait(queue_pkt.size() > 0);
            pkt = queue_pkt.pop_back();
            s2d_mb.put(pkt);
            $display("%0t:[STIMULUS] Send packet to driver",$time);
        end
    endtask

endclass
