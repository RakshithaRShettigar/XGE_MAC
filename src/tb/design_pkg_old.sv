`ifndef DESIGN_PKG_OLD_INCLUDED_
`define DESIGN_PKG_OLD_INCLUDED_

package design_pkg_old;


`include "../rtl/verilog/fault_sm.v"
`include "../rtl/verilog/generic_mem_small.v"
`include "../rtl/verilog/generic_mem_medium.v"
`include "../rtl/verilog/generic_fifo_ctrl.v"
`include "../rtl/verilog/generic_fifo.v"
`include "../rtl/verilog/meta_sync.v"
`include "../rtl/verilog/meta_sync_single.v"
`include "../rtl/verilog/rx_hold_fifo.v"
`include "../rtl/verilog/rx_data_fifo.v"
`include "../rtl/verilog/rx_dequeue.v"
`include "../rtl/verilog/rx_enqueue.v"
`include "../rtl/verilog/sync_clk_core.v"
`include "../rtl/verilog/sync_clk_wb.v"
`include "../rtl/verilog/sync_clk_xgmii_tx.v"
`include "../rtl/verilog/tx_hold_fifo.v"
`include "../rtl/verilog/tx_data_fifo.v"
`include "../rtl/verilog/tx_dequeue.v"
`include "../rtl/verilog/tx_enqueue.v"
`include "../rtl/verilog/wishbone_if.v"
`include "../rtl/verilog/xge_mac.v"

  
endpackage

`endif
