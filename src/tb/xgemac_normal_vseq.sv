`ifndef XGEMAC_NORMAL_VSEQ_INCLUDED
`define XGEMAC_NORMAL_VSEQ_INCLUDED

//--------------------------------------------------------------------------------------------
// Class: xgemac_normal_vseq
//--------------------------------------------------------------------------------------------
class xgemac_normal_vseq extends xgemac_base_vseq;
  `uvm_object_utils(xgemac_normal_vseq)
  
  //Variable : in_seq_nornal_h
  //Declaring handle to the virtual sequence
 
  in_seq_normal in_seq_normal_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  
  extern function new(string name = "xgemac_normal_vseq");
  extern task body();


endclass  

//--------------------------------------------------------------------------------------------
// Construct: new
//  name : xgemac_normal_vseq
//--------------------------------------------------------------------------------------------

function xgemac_normal_vseq::new(string name = "xgemac_normal_vseq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : body
// Used to creates the handle and starts the sequences
//  name : xgemac_normal_vseq
//--------------------------------------------------------------------------------------------
   task xgemac_normal_vseq::body();
    super.body();
    `uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW);
     in_seq_normal_h = in_seq_normal::type_id::create("in_seq_normal_h");
     
     fork
      in_seq_normal_h.start(in_seqr_h);
      wish_seq_h.start(wish_seqr_h);
      reset_seq_h.start(reset_seqr_h);
    join
      
   endtask
    
`endif
