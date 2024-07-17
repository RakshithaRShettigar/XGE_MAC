`ifndef WISH_SEQR_INCLUDED_
`define WISH_SEQR_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: wish_seqr
//--------------------------------------------------------------------------------------------


class wish_seqr extends uvm_sequencer#(wish_seq_item);
  `uvm_component_utils(wish_seqr)

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes the wish sequencer class component
//
// Parameters:
//  name - wish_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
  
  function new(string name = "wish_seqr", uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass: wish_seqr

`endif
