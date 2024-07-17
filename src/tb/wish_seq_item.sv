`ifndef WISH_SEQ_ITEM_INCLUDED_
`define WISH_SEQ_ITEM_INCLUDED_

`include "uvm_macros.svh"
import uvm_pkg::*;
 
class wish_seq_item extends uvm_sequence_item;
 rand bit [7:0] wb_adr_i; // Address input 
  rand bit wb_cyc_i; // Wishbone cycle
  rand bit [31:0] wb_dat_i; // Wishbone data input
  rand bit wb_stb_i; // Wishbone strobe
  rand bit wb_we_i; // Wishbone write enable
  bit wb_ack_o;     // Wishbone acknowledge
  bit [31:0] wb_dat_o; // Wishbone data output
  bit wb_int_o;        // Wishbone interrupt signal

 //Factory registration
  `uvm_object_utils_begin(wish_seq_item)
  `uvm_field_int(wb_adr_i, UVM_ALL_ON)
  `uvm_field_int(wb_cyc_i, UVM_ALL_ON)
  `uvm_field_int(wb_dat_i, UVM_ALL_ON)
  `uvm_field_int(wb_stb_i, UVM_ALL_ON)
  `uvm_field_int(wb_we_i,  UVM_ALL_ON)
  `uvm_object_utils_end


 //constraint : to ensure that wishbone address is inside the given register addresses
   constraint reg_constraints { wb_adr_i inside {'h0, 'h10,'h08, 'h0c, 'h80, 'h84, 'h90, 'h94} ;}  

 //class constructor
  function new(string name = "wish_seq_item");
    super.new(name);
  endfunction
 

endclass

`endif
