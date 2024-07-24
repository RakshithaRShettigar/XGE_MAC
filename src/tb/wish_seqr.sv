`ifndef WISH_SEQR_INCLUDED_
`define WISH_SEQR_INCLUDED_

class wish_seqr extends uvm_sequencer#(wish_seq_item);
  `uvm_component_utils(wish_seqr)
  
  function new(string name = "wish_seqr", uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass

`endif
