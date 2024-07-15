`timescale 1ps / 1ps

`ifndef TB_INCLUDED_
`define TB_INCLUDED_
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "wish_intf.sv"
`include "pkt_interface.sv"
`include "design_pkg_old.sv"
`include "xgemac_pkg.sv"
`include "xgemac_defines.sv"


module xgemac_top;
import xgemac_pkg::*;

   bit wb_clk_i,clk_156m25;
 
always #1200 clk_156m25 = ~clk_156m25; // frequency 156.25MHz
always #5000 wb_clk_i = ~wb_clk_i; // We have considered the Wishbone clock frequency as 100MHz


  initial begin
   
    clk_156m25 = 0;
    wb_clk_i = 0;
   
  end
  wish_intf wish_vif(wb_clk_i);  
                                                       
  pkt_interface pkt_vif(clk_156m25);                                                                           
   xge_mac DUV(.wb_int_o(wish_vif.wb_int_o),
               .wb_dat_o(wish_vif.wb_dat_o),
               .wb_ack_o(wish_vif.wb_ack_o),
              .pkt_tx_full(pkt_vif.pkt_tx_full),
              .pkt_rx_val(pkt_vif.pkt_rx_val),
              .pkt_rx_sop(pkt_vif.pkt_rx_sop),
              .pkt_rx_mod(pkt_vif.pkt_rx_mod),
              .pkt_rx_err(pkt_vif.pkt_rx_err),
              .pkt_rx_eop(pkt_vif.pkt_rx_eop),
              .pkt_rx_data(pkt_vif.pkt_rx_data),
              .pkt_rx_avail(pkt_vif.pkt_rx_avail),
              .wb_we_i(wish_vif.wb_we_i),
              .wb_stb_i(wish_vif.wb_stb_i),
              .wb_rst_i(wish_vif.wb_rst_i),
              .wb_dat_i(wish_vif.wb_dat_i),
              .wb_cyc_i(wish_vif.wb_cyc_i),
              .wb_clk_i(wish_vif.wb_clk_i),
              .wb_adr_i(wish_vif.wb_adr_i),
              .reset_156m25_n (pkt_vif.reset_156m25_n),
              .pkt_tx_val(pkt_vif.pkt_tx_val),
              .pkt_tx_sop(pkt_vif.pkt_tx_sop),
              .pkt_tx_mod(pkt_vif.pkt_tx_mod),
              .pkt_tx_eop(pkt_vif.pkt_tx_eop),
              .pkt_tx_data(pkt_vif.pkt_tx_data),
              .pkt_rx_ren(pkt_vif.pkt_rx_ren),
              .clk_156m25(pkt_vif.clk_156m25));
 
  

  initial begin
   
    uvm_config_db#(virtual wish_intf)::set(null, "", "wish_vif", wish_vif);
    
    uvm_config_db#(virtual pkt_interface)::set(null, "", "pkt_vif", pkt_vif);

    run_test("xgemac_base_test");
   
  end

 initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
 end
 
endmodule
 
`endif
