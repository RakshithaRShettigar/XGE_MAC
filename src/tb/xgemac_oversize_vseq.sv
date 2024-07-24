`ifndef XGEMAC_OVERSIZE_VSEQ_INCLUDED
`define XGEMAC_OVERSIZE_VSEQ_INCLUDED

//--------------------------------------------------------------------------------------------
// Class: xgemac_oversize_vseq
//--------------------------------------------------------------------------------------------
class xgemac_oversize_vseq extends xgemac_base_vseq;
  `uvm_object_utils(xgemac_oversize_vseq)
  
  //Variable : in_seq_oversize_h
  //Declaring handle to the virtual sequence
 
  in_seq_oversize in_seq_oversize_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  
  extern function new(string name = "xgemac_oversize_vseq");
  extern task body();


endclass  

//--------------------------------------------------------------------------------------------
// Construct: new
//  name : xgemac_oversized_vseq
//--------------------------------------------------------------------------------------------

function xgemac_oversize_vseq::new(string name = "xgemac_oversize_vseq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : body
// Used to creates the handle and starts the sequences
//  name : xgemac_oversize_vseq
//--------------------------------------------------------------------------------------------
   task xgemac_oversize_vseq::body();
    `uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW);
     in_seq_oversize_h = in_seq_oversize::type_id::create("in_seq_oversize_h");
     
     fork
      in_seq_oversize_h.start(in_seqr_h);
      wish_seq_h.start(wish_seqr_h);
      reset_seq_h.start(reset_seqr_h);
    join
      
   endtask
    
`endif
