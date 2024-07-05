`ifndef RESET_SEQR_INCLUDED_
`define RESET_SEQR_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: reset_seqr
//--------------------------------------------------------------------------------------------

class reset_seqr extends uvm_sequencer#(reset_seq_item);
  `uvm_component_utils(reset_seqr)
   extern function new(string name = "reset_seqr", uvm_component parent);
  endclass

 //--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes the reset sequencer class component
//
// Parameters:
//  name - reset_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------

     function new(string name = "reset_seqr", uvm_component parent);
    super.new(name, parent);
  
     endfunction

     `endif
