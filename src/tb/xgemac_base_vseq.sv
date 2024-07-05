`ifndef XGEMAC_BASE_VSEQ_INCLUDED_
`define XGEMAC_BASE_VSEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: xgemac_base_vseq
// Holds the handle of actual in_sqr, wish_sqr and reset_sqr, and holds the objects of wish_seq, reset_seq.
//--------------------------------------------------------------------------------------------
class xgemac_base_vseq extends uvm_sequence;

  `uvm_object_utils(apb_virtual_base_seq)
  
  //Variable : in_seqr_h
  //Declaring handle to the in sequencer
  in_seqr in_seqr_h;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "apb_virtual_base_seq");
  extern task body();
endclass : apb_virtual_base_seq
