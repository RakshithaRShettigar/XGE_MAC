`ifndef TB_INCLUDED_
`define TB_INCLUDED_
 
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "wish_intf.sv"
`include "wish_test.sv"
`include "pkt_intf.sv"
`include "design.sv"
 
module xgemac_top;

   bit wb_clk_i,clk_156m25, reset_156m25_n, wb_rst_i;
 
always #5 clk_156m25 = ~clk_156m25;
always #5 wb_clk_i = ~wb_clk_i;


  initial begin
   
    clk_156m25 = 0;
    wb_clk_i = 0;
   
  end
  wish_intf wish_vif(wb_clk_i, wb_rst_i);  

  wishbone_interface wish_vif(wb_clk_i,wb_rst_i);                                                        
  pkt_interface pkt_vif(clk_156m25,reset_156m25_n);                                                                           
  xge_mac DUV(.wb_int_o(pkt_vif.wb_int_o),
              . wb_dat_o(pkt_vif.wb_dat_o),
              . wb_ack_o(pkt_vif.wb_ack_o),
              . pkt_tx_full(pkt_vif.pkt_tx_full),
              .pkt_rx_val(pkt_vif.pkt_rx_val),
              .pkt_rx_sop(pkt_vif.pkt_rx_sop),
              . pkt_rx_mod(pkt_vif.pkt_rx_mod),
              . pkt_rx_err(pkt_vif.pkt_rx_err),
              . pkt_rx_eop(pkt_vif.pkt_rx_eop),
              .pkt_rx_data(pkt_vif.pkt_rx_data),
              . pkt_rx_avail(pkt_vif.pkt_rx_avail),
              . wb_we_i(wish_vif.wb_we_i),
              . wb_stb_i(wish_vif.wb_stb_i),
              . wb_rst_i(wish_vif.wb_rst_i),
              . wb_dat_i(wish_vif.wb_dat_i),
              .wb_cyc_i(wish_vif.wb_cyc_i),
              . wb_clk_i(wish_vif.wb_clk_i),
              . wb_adr_i(wish_vif.wb_adr_i),
              .reset_156m25_n (pkt_vif.reset_156m25_n),
              . pkt_tx_val(pkt_vif.pkt_tx_val),
              . pkt_tx_sop(pkt_vif.pkt_tx_sop),
              . pkt_tx_mod(pkt_vif.pkt_tx_mod),
              . pkt_tx_eop(pkt_vif.pkt_tx_eop),
              .pkt_tx_data(pkt_vif.pkt_tx_data),
              . pkt_rx_ren(pkt_vif.pkt_rx_ren),
              . clk_156m25(pkt_vif.clk_156m25));
 
  

  initial begin
    uvm_config_db#(virtual wish_intf)::set(null, "", "wish_vif", wish_vif);
    
   uvm_config_db#(virtual pkt_interface)::set(null, "", "pkt_vif", pkt_vif);

    $dumpfile("dump.vcd"); 
    $dumpvars;
    run_test("wish_test");
  end
endmodule
 
`endif
