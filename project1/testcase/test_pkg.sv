package test_pkg;

  import timer_pkg::*;
  `include"base_test.sv"
  `include"df_test.sv"
  `include"default_value_register.sv"
  `include"read_write_register.sv"
  `include"reset_on_the_fly.sv"
  `include"reserved_register.sv"
  `include"consecutive_apb_access.sv"
  `include"clk_div_no_div.sv"
  `include"clk_div_by2.sv"
  `include"clk_div_by4.sv"
  `include"clk_div_by8.sv"
  `include"change_clk_div_while_running.sv"
  `include"count_up.sv"
  `include"count_down.sv"
  `include"count_up_with_tdr.sv"
  `include"count_down_with_tdr.sv"
  `include"count_stop.sv"
  `include"count_continue_after_stop.sv"
    
  `include"interrupt_overflow.sv"
  `include"interrupt_underflow.sv"
  `include"interrupt_clear_w1c.sv"
  `include"interrupt_disabled_overflow.sv"
  `include"interrupt_disabled_underflow.sv"
  `include"interrupt_both_enabled.sv"
  `include"interrupt_enable_when_status_already_set.sv"
 
  `include"count_up_clkdiv0.sv"
  `include"count_up_clkdiv2.sv"
  `include"count_up_clkdiv4.sv"
  `include"count_up_clkdiv8.sv"
  `include"count_down_clkdiv0.sv"
  `include"count_down_clkdiv2.sv"
  `include"count_down_clkdiv4.sv"
  `include"count_down_clkdiv8.sv"
  `include"count_up_tdr_clkdiv0.sv"
  `include"count_up_tdr_clkdiv2.sv"
  `include"count_up_tdr_clkdiv4.sv"
  `include"count_up_tdr_clkdiv8.sv"
  `include"count_down_tdr_clkdiv0.sv"
  `include"count_down_tdr_clkdiv2.sv"
  `include"count_down_tdr_clkdiv4.sv"
  `include"count_down_tdr_clkdiv8.sv"

  `include"count_up_stop_down.sv"
  `include"count_down_stop_up.sv"
  `include"count_up_stop_load_up.sv"
  `include"count_up_stop_load_down.sv"
  `include"count_down_stop_load_down.sv"
  `include"count_down_stop_load_up.sv"
  `include"count_up_stop_change_clkdiv_samedir.sv"
  `include"count_up_stop_change_clkdiv_down.sv"
  `include"count_down_stop_change_clkdiv_samedir.sv"
  `include"count_down_stop_change_clkdiv_up.sv"
  `include"count_up_stop_change_clkdiv_load_samedir.sv"
  `include"count_up_stop_change_clkdiv_load_down.sv"
  `include"count_down_stop_change_clkdiv_load_samedir.sv"
  `include"count_down_stop_change_clkdiv_load_up.sv"

  `include"count_up_with_data_min.sv"
  `include"count_up_with_data_max.sv"
  `include"count_down_with_data_min.sv"
  `include"count_down_with_data_max.sv"
  

    
endpackage



