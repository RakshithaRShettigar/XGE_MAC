`ifndef XGEMAC_BASE_VSEQ_INCLUDED_
`define XGEMAC_BASE_VSEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: xgemac_base_vseq
// Holds the handle of actual in_sqr, wish_sqr and reset_sqr, and holds the objects of wish_seq, reset_seq.
//--------------------------------------------------------------------------------------------
class xgemac_base_vseq extends uvm_sequence;

  `uvm_object_utils(xgemac_base_vseq)
  
  //Variable : in_seqr_h
  //Declaring handle to the in sequencer
  in_seqr in_seqr_h;

  //Variable : wish_seqr_h
  //Declaring handle to the wish sequencer
  wish_seqr wish_seqr_h;

  //Variable : reset_seqr_h
  //Declaring handle to the reset sequencer
  reset_seqr reset_seqr_h;

  //Variable : wish_seq_h
  //Declaring handle to the wish sequence
  wish_seq wish_seq_h;

  //Variable : reset_seq_h
  //Declaring handle to the reset sequence
  reset_seq reset_seq_h;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "xgemac_base_vseq");
  extern task body();
endclass : xgemac_base_vseq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - xgemac_base_vseq
//--------------------------------------------------------------------------------------------
function xgemac_base_vseq::new(string name = "xgemac_base_vseq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : body
// Used to create the wish seqr to master seqr
//
// Parameters:
//  name - xgemac_base_vseq
//--------------------------------------------------------------------------------------------
task xgemac_base_vseq::body();
  super.body();
  `uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW);
  wish_seq_h = wish_seq::type_id::create("wish_seq_h");
  reset_seq_h = reset_seq::type_id::create("reset_seq_h");
endtask
`endif
