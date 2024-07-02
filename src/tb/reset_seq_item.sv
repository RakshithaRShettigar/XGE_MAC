`ifndef RESET_SEQ_ITEM_INCLUDED_
`define RESET_SEQ_ITEM_INCLUDED_

class reset_seq_item extends uvm_sequence_item;

`uvm_object_utils_begin(reset_seq_item)
`uvm_field_int(reset_156m25_n, UVM_ALL_ON)
`uvm_field_int(wb_rst_i, UVM_ALL_ON)
`uvm_object_utils_end

//RESET SIGNALS
rand bit reset_156m25_n;
rand bit wb_rst_i;

//Class Constructor
function new(string name = "reset_seq_item");
    super.new(name);
endfunction: new

endclass: reset_seq_item

`endif