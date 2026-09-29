`timescale 1ns/1ps

module testbench; 
  import timer_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  timer_top u_dut(
    .ker_clk(d_if.ker_clk),       
    .pclk(d_if.pclk),       
    .presetn(d_if.presetn),    
    .psel(d_if.psel),       
    .penable(d_if.penable),    
    .pwrite(d_if.pwrite),     
    .paddr(d_if.paddr),      
    .pwdata(d_if.pwdata),     
    .prdata(d_if.prdata),     
    .pready(d_if.pready),     
    .interrupt(d_if.interrupt));

  initial begin
    d_if.presetn = 0;
    #100ns d_if.presetn = 1;
  end

  // 50 MHz
  initial begin
    d_if.pclk = 0;
    forever begin 
      #10ns;
      d_if.pclk = ~d_if.pclk;
    end
  end
 
  // 200 MHz
  initial begin
    d_if.ker_clk = 1;
    forever begin 
      #2.5ns;
      d_if.ker_clk = ~d_if.ker_clk;
    end
  end


  base_test base = new();
  df_test df = new();
  default_value_register        df1 = new();
  read_write_register           df2 = new();
  reset_on_the_fly              df3 = new();
  reserved_register             df4 = new();
  consecutive_apb_access        df5 = new();
  clk_div_no_div                df6 = new(); 
  clk_div_by2                   df7 = new();
  clk_div_by4                   df8 = new(); 
  clk_div_by8                   df9 = new();
  change_clk_div_while_running  df10 = new();
  count_up_df                   df11 = new();
  count_down_df                 df12 = new();
  count_up_with_tdr             df13 = new();
  count_down_with_tdr           df14 = new();
  count_stop                    df15 = new();
  count_continue_after_stop     df16 = new();
  interrupt_overflow            df17 = new();
  interrupt_underflow           df18 = new();
  interrupt_clear_w1c           df19 = new();
  interrupt_disabled_overflow   df20 = new();
  interrupt_disabled_underflow  df21 = new();
  interrupt_both_enabled        df22 = new();
  interrupt_enable_when_status_already_set  df23 = new();
  count_up_clkdiv0              df24 = new();
  count_up_clkdiv2              df25 = new();
  count_up_clkdiv4              df26 = new();
  count_up_clkdiv8              df27 = new();
  count_down_clkdiv0            df28 = new();
  count_down_clkdiv2            df29 = new();
  count_down_clkdiv4            df30 = new();
  count_down_clkdiv8            df31 = new();
  count_up_tdr_clkdiv0          df32 = new();
  count_up_tdr_clkdiv2          df33 = new();
  count_up_tdr_clkdiv4          df34 = new();
  count_up_tdr_clkdiv8          df35 = new();
  count_down_tdr_clkdiv0        df36 = new();
  count_down_tdr_clkdiv2        df37 = new();
  count_down_tdr_clkdiv4        df38 = new();
  count_down_tdr_clkdiv8        df39 = new();
  count_up_stop_down            df40 = new();
  count_down_stop_up            df41 = new();
  count_up_stop_load_up         df42 = new();
  count_up_stop_load_down       df43 = new();
  count_down_stop_load_down     df44 = new();
  count_down_stop_load_up       df45 = new();
  count_up_stop_change_clkdiv_samedir   df46 = new();
  count_up_stop_change_clkdiv_down      df47 = new();
  count_down_stop_change_clkdiv_samedir df48 = new();
  count_down_stop_change_clkdiv_up      df49 = new();
  count_up_stop_change_clkdiv_load_samedir      df50 = new();
  count_up_stop_change_clkdiv_load_down         df51 = new();
  count_down_stop_change_clkdiv_load_samedir    df52 = new();
  count_down_stop_change_clkdiv_load_up         df53 = new();
  count_up_with_data_min        df54 = new();
  count_up_with_data_max        df55 = new();
  count_down_with_data_min      df56 = new();
  count_down_with_data_max      df57 = new();


  initial begin
    d_if.psel = 1'b0;       
    d_if.penable = 1'b0;     
    d_if.pwrite = 1'b0;    
    d_if.paddr = 8'b00;      
    d_if.pwdata = 8'b0;
    #100ns;
    if($test$plusargs("df_test"))begin
        base = df;
    end else if($test$plusargs("default_value_register")) begin
        base = df1;
    end else if($test$plusargs("read_write_register")) begin
        base = df2;
    end else if($test$plusargs("reset_on_the_fly")) begin
        base = df3;
    end else if($test$plusargs("reserved_register")) begin
        base = df4;
    end else if($test$plusargs("consecutive_apb_access")) begin
        base = df5;
    end else if($test$plusargs("clk_div_no_div")) begin
        base = df6;
    end else if($test$plusargs("clk_div_by2")) begin
        base = df7;
    end else if($test$plusargs("clk_div_by4")) begin
        base = df8;
    end else if($test$plusargs("clk_div_by8")) begin
        base = df9;
    end else if($test$plusargs("change_clk_div_while_running")) begin
        base = df10;
    end else if($test$plusargs("count_up_df")) begin
        base = df11;
    end else if($test$plusargs("count_down_df")) begin
        base = df12;
    end else if($test$plusargs("count_up_with_tdr")) begin
        base = df13;
    end else if($test$plusargs("count_down_with_tdr")) begin
        base = df14;
    end else if($test$plusargs("count_stop")) begin
        base = df15;
    end else if($test$plusargs("count_continue_after_stop")) begin
        base = df16;
    end else if($test$plusargs("interrupt_overflow")) begin
        base = df17;
    end else if($test$plusargs("interrupt_underflow")) begin
        base = df18;
    end else if($test$plusargs("interrupt_clear_w1c")) begin
        base = df19;
    end else if($test$plusargs("interrupt_disabled_overflow")) begin
        base = df20;
    end else if($test$plusargs("interrupt_disabled_underflow")) begin
        base = df21;
    end else if($test$plusargs("interrupt_both_enabled")) begin
        base = df22;
    end else if($test$plusargs("interrupt_enable_when_status_already_set")) begin
        base = df23;
    end else if($test$plusargs("count_up_clkdiv0")) begin
        base = df24;
    end else if($test$plusargs("count_up_clkdiv2")) begin
        base = df25;
    end else if($test$plusargs("count_up_clkdiv4")) begin
        base = df26;
    end else if($test$plusargs("count_up_clkdiv8")) begin
        base = df27;
    end else if($test$plusargs("count_down_clkdiv0")) begin
        base = df28;
    end else if($test$plusargs("count_down_clkdiv2")) begin
        base = df29;
    end else if($test$plusargs("count_down_clkdiv4")) begin
        base = df30;
    end else if($test$plusargs("count_down_clkdiv8")) begin
        base = df31;
    end else if($test$plusargs("count_up_tdr_clkdiv0")) begin
        base = df32;
    end else if($test$plusargs("count_up_tdr_clkdiv2")) begin
        base = df33;
    end else if($test$plusargs("count_up_tdr_clkdiv4")) begin
        base = df34;
    end else if($test$plusargs("count_up_tdr_clkdiv8")) begin
        base = df35;
    end else if($test$plusargs("count_down_tdr_clkdiv0")) begin
        base = df36;
    end else if($test$plusargs("count_down_tdr_clkdiv2")) begin
        base = df37;
    end else if($test$plusargs("count_down_tdr_clkdiv4")) begin
        base = df38;
    end else if($test$plusargs("count_down_tdr_clkdiv8")) begin
        base = df39;
    end else if($test$plusargs("count_up_stop_down")) begin
        base = df40;
    end else if($test$plusargs("count_down_stop_up")) begin
        base = df41;
    end else if($test$plusargs("count_up_stop_load_up")) begin
        base = df42;
    end else if($test$plusargs("count_up_stop_load_down")) begin
        base = df43;
    end else if($test$plusargs("count_down_stop_load_down")) begin
        base = df44;
    end else if($test$plusargs("count_down_stop_load_up")) begin
        base = df45;
    end else if($test$plusargs("count_up_stop_change_clkdiv_samedir")) begin
        base = df46;
    end else if($test$plusargs("count_up_stop_change_clkdiv_down")) begin
        base = df47;
    end else if($test$plusargs("count_down_stop_change_clkdiv_samedir")) begin
        base = df48;
    end else if($test$plusargs("count_down_stop_change_clkdiv_up")) begin
        base = df49;
    end else if($test$plusargs("count_up_stop_change_clkdiv_load_samedir")) begin
        base = df50;
    end else if($test$plusargs("count_up_stop_change_clkdiv_load_down")) begin
        base = df51;
    end else if($test$plusargs("count_down_stop_change_clkdiv_load_samedir")) begin
        base = df52;
    end else if($test$plusargs("count_down_stop_change_clkdiv_load_up")) begin
        base = df53;
    end else if($test$plusargs("count_up_with_data_min")) begin
        base = df54;
    end else if($test$plusargs("count_up_with_data_max")) begin
        base = df55;
    end else if($test$plusargs("count_down_with_data_min")) begin
        base = df56;
    end else if($test$plusargs("count_down_with_data_max")) begin
        base = df57;
    end


    base.dut_vif = d_if;
    base.run();
   

    #1ms;
    $display("[testbench] Time out....Seems your tb is hang!");
    $finish;
  end

    
endmodule
