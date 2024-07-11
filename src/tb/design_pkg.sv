`ifndef DESIGN_PKG_INCLUDED
`define DESIGN_PKG_INCLUDED

package design_pkg;


vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../RTL/verilog/fault_sm.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/generic_mem_small.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/generic_mem_medium.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/generic_fifo_ctrl.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/generic_fifo.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/meta_sync.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/meta_sync_single.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/rx_hold_fifo.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/rx_data_fifo.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/rx_dequeue.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/rx_enqueue.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/sync_clk_core.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/sync_clk_wb.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/sync_clk_xgmii_tx.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/tx_hold_fifo.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/tx_data_fifo.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/tx_dequeue.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/tx_enqueue.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/wishbone_if.v

vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../rtl/verilog/xge_mac.v



vlog -timescale 1ps/1ps +incdir+../../rtl/include ../../tbench/verilog/tb_xge_mac.v


endpackage

`endif

