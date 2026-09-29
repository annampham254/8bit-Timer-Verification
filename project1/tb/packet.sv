class packet;
    typedef enum bit {READ = 1'b0, WRITE = 1'b1} transfer_enum;
    rand transfer_enum transfer;
    rand bit [7:0] addr;
    rand bit [7:0] data;

    //constraint addr_diss {[8'h00:8'h03] := 80, [8'h04:8'hff] := 20};

    function new();
    endfunction
    
endclass
