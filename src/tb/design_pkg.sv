`ifndef DESIGN_PKG_INCLUDED
`define DESIGN_PKG_INCLUDED

package design_pkg;


`include "../RTL/verilog/fault_sm.v"
`include "../RTL/verilog/generic_mem_small.v"
`include "../RTL/verilog/generic_mem_medium.v"
`include "../RTL/verilog/generic_fifo_ctrl.v"
`include "../RTL/verilog/generic_fifo.v"
`include "../RTL/verilog/meta_sync.v"
`include "../RTL/verilog/meta_sync_single.v"
`include "../RTL/verilog/rx_hold_fifo.v"
`include "../RTL/verilog/rx_data_fifo.v"
`include "../RTL/verilog/rx_dequeue.v"
`include "../RTL/verilog/rx_enqueue.v"
`include "../RTL/verilog/sync_clk_core.v"
`include "../RTL/verilog/sync_clk_wb.v"
`include "../RTL/verilog/sync_clk_xgmii_tx.v"
`include "../RTL/verilog/tx_hold_fifo.v"
`include "../RTL/verilog/tx_data_fifo.v"
`include "../RTL/verilog/tx_dequeue.v"
`include "../RTL/verilog/tx_enqueue.v"
`include "../RTL/verilog/wishbone_if.v"
`include "../RTL/verilog/xge_mac.v"

  
endpackage

`endif

