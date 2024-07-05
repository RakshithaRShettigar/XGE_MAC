`ifndef XGEMAC_UNDERSIZE_VSEQ_INCLUDED
`define XGEMAC_UNDERSIZE_VSEQ_INCLUDED


class xgemac_undersize_vseq extends xgemac_base_vseq;

  //factory registration
  `uvm_object_utils(xgemac_undersize_vseq)
  
 // Declare the in_sequence_undersize handle
  in_seq_undersize in_seq_undersize_h;

  extern function new(string name = "xgemac_undersize_vseq");
  extern task body();
    
endclass : xgemac_undersize_vseq
    
  //class constructor
  function xgemac_undersize_vseq :: new(string name = "xgemac_undersize_vseq");
   super.new(name);
  endfunction 

  //task body
   task  xgemac_undersize_vseq :: body();
    `uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW);
     in_seq_normal_h = in_seq_normal::type_id::create("in_seq_normal_h"); 
     fork
      in_seq_undersize_h.start(in_seqr_h);
      wish_seq_h.start(wish_seqr_h);
      reset_seq_h.start(reset_seqr_h);
    join      
   endtask
    
`endif
