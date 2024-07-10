`ifndef TB_INCLUDED_
`define TB_INCLUDED_

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "wish_intf.sv"
`include "wish_test.sv"
`include "design.sv"

module xgemac_top;
 
  bit clk_156m25;
  bit wb_clk_i;
  bit reset_156m25_n;
  bit wb_rst_i;
 
always #5 clk_156m25 = ~clk_156m25;
always #5 wb_clk_i = ~wb_clk_i;
  
  initial begin
    clk_156m25 = 0;
    wb_clk_i = 0;
  end
  
  wish_intf wish_vif(wb_clk_i, wb_rst_i);  
   
  xge_mac uut(
               .wb_clk_i(wish_vif.wb_clk_i),
               .wb_rst_i(wish_vif.wb_rst_i),
               .wb_adr_i(wish_vif.wb_adr_i),
               .wb_cyc_i(wish_vif.wb_cyc_i),
               .wb_dat_i(wish_vif.wb_dat_i),
               .wb_stb_i(wish_vif.wb_stb_i),
               .wb_we_i(wish_vif.wb_we_i),
               .wb_ack_o(wish_vif.wb_ack_o),
               .wb_dat_o(wish_vif.wb_dat_o),
               .wb_int_o(wish_vif.wb_int_o)
               );
 
  initial begin
    uvm_config_db#(virtual wish_intf)::set(null, "", "wish_vif", wish_vif);
    
    
    $dumpfile("dump.vcd"); 
    $dumpvars;
    run_test("wish_test");
  end
endmodule

`endif
 
